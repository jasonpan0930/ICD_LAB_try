"""
Pack quantized Mamba weights into mamba_weight_storage.v byte map.

Z: per-tensor 9-bit sign-magnitude (2-byte load).
Bias: Q8.8 clamped to signed 12-bit [-2048, 2047], packed MSB-first (1.5 bytes/ch).
"""
from __future__ import annotations

import numpy as np
import torch

Z_MAX = 255
BIAS_WIDTH = 12
BIAS_I12_MIN = -(1 << 11)
BIAS_I12_MAX = (1 << 11) - 1
WEIGHT_BYTES = 285


def clip_z(z: float) -> int:
    return int(np.clip(int(round(z)), -Z_MAX, Z_MAX))


def pack_z9_sm_bytes(z_point: int) -> bytes:
    z = clip_z(z_point)
    mag = abs(z) & 0xFF
    sign = 1 if z < 0 else 0
    z9 = (sign << 8) | mag
    return bytes([(z9 >> 8) & 0xFF, z9 & 0xFF])


def clamp_bias_i12(v: int) -> int:
    return max(BIAS_I12_MIN, min(BIAS_I12_MAX, int(v)))


def bias_to_i12_q88(bias: torch.Tensor) -> list[int]:
    """Q8.8 integer bias, clamped to 12-bit signed range."""
    b = torch.clamp(torch.round(bias.float() * 256.0), BIAS_I12_MIN, BIAS_I12_MAX).to(torch.int32)
    return [clamp_bias_i12(int(x)) for x in b.flatten()]


def pack_i12_msb(values: list[int]) -> bytes:
    """Pack signed 12-bit values MSB-first (matches weight_storage byte load order)."""
    out = bytearray()
    acc = 0
    nbits = 0
    for v in values:
        v = clamp_bias_i12(v)
        if v < 0:
            v = (1 << 12) + v
        acc = (acc << 12) | (v & 0xFFF)
        nbits += 12
        while nbits >= 8:
            nbits -= 8
            out.append((acc >> nbits) & 0xFF)
    if nbits:
        out.append((acc << (8 - nbits)) & 0xFF)
    return bytes(out)


def ln_bias_bytes(n_ch: int) -> int:
    return (n_ch * BIAS_WIDTH + 7) // 8


def quantize_weight_uint8_per_tensor(weight: torch.Tensor):
    w = weight.detach().float()
    t_min = w.min().item()
    t_max = w.max().item()
    if t_min == t_max:
        w_q = torch.zeros_like(w, dtype=torch.int32)
        return w_q, 1.0, 0, 0, 16
    scale = (t_max - t_min) / 255.0
    z_point = clip_z(-t_min / scale)
    w_q = torch.clamp(torch.round(w / scale) + z_point, 0, 255).to(torch.int32)
    n_shift = 16
    while scale * (1 << n_shift) > 65535 and n_shift > 0:
        n_shift -= 1
    m_mult = int(round(scale * (1 << n_shift)))
    return w_q, scale, z_point, m_mult, n_shift


def pack_weights_row_major_msb(w_q: torch.Tensor) -> bytes:
    out = bytearray()
    for r in range(w_q.shape[0]):
        for c in range(w_q.shape[1]):
            out.append(int(w_q[r, c].item()) & 0xFF)
    return bytes(out)


def append_in1_linear_block(blob: bytearray, weight: torch.Tensor, bias: torch.Tensor) -> None:
    w_q, _, z_point, m_mult, n_shift = quantize_weight_uint8_per_tensor(weight)
    blob.extend(pack_weights_row_major_msb(w_q))
    blob.extend(pack_z9_sm_bytes(z_point))
    blob.extend(pack_i12_msb(bias_to_i12_q88(bias)))
    blob.extend([(m_mult >> 8) & 0xFF, m_mult & 0xFF])
    blob.append(n_shift & 0x1F)


def append_proj_out_block(blob: bytearray, weight: torch.Tensor, bias: torch.Tensor) -> None:
    w_q, _, z_point, m_mult, n_shift = quantize_weight_uint8_per_tensor(weight)
    blob.extend(pack_weights_row_major_msb(w_q))
    blob.extend(pack_z9_sm_bytes(z_point))
    blob.extend(pack_i12_msb(bias_to_i12_q88(bias)))
    blob.extend([(m_mult >> 8) & 0xFF, m_mult & 0xFF])
    blob.append(n_shift & 0x1F)


def fuse_proj_in_x_proj(proj_in_weight, proj_in_bias, x_proj_weight, x_proj_bias):
    w_pi = proj_in_weight.squeeze(-1)
    w_xp = x_proj_weight
    w_fused = (w_xp @ w_pi).unsqueeze(-1)
    b_fused = x_proj_bias + (w_xp @ proj_in_bias)
    return w_fused, b_fused


def pack_u16_be_list(values: list[int]) -> bytes:
    out = bytearray()
    for v in values:
        v &= 0xFFFF
        out.extend([(v >> 8) & 0xFF, v & 0xFF])
    return bytes(out)


def pack_const_a(A_log: torch.Tensor) -> bytes:
    a_val = -torch.exp(A_log.float())
    a_q = torch.clamp(torch.round(a_val * 256.0), -32768, 32767).to(torch.int32)
    return pack_u16_be_list([int(a_q[r, c].item()) for r in range(a_q.shape[0]) for c in range(a_q.shape[1])])


def pack_const_d(D: torch.Tensor) -> bytes:
    d_q = torch.clamp(torch.round(D.float() * 256.0), -32768, 32767).to(torch.int32)
    return pack_u16_be_list([int(d_q[i].item()) for i in range(d_q.numel())])


def pack_weight_storage_from_state_dict(state_dict: dict, d_model: int = 8, d_state: int = 8) -> bytes:
    blob = bytearray()

    append_in1_linear_block(blob, state_dict["proj_in.weight"], state_dict["proj_in.bias"])

    w_mx, b_mx = fuse_proj_in_x_proj(
        state_dict["proj_in.weight"],
        state_dict["proj_in.bias"],
        state_dict["x_proj.weight"],
        state_dict["x_proj.bias"],
    )
    append_in1_linear_block(blob, w_mx, b_mx)

    append_in1_linear_block(blob, state_dict["dt_proj.weight"], state_dict["dt_proj.bias"])
    append_proj_out_block(blob, state_dict["proj_out.weight"], state_dict["proj_out.bias"])
    blob.extend(pack_const_a(state_dict["A_log"]))
    blob.extend(pack_const_d(state_dict["D"]))

    if len(blob) != WEIGHT_BYTES:
        raise ValueError(f"packed {len(blob)} bytes, expected {WEIGHT_BYTES}")
    return bytes(blob)


def write_hex_file(blob: bytes, path) -> None:
    path = __import__("pathlib").Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("".join(f"{b:02x}\n" for b in blob), encoding="ascii")
