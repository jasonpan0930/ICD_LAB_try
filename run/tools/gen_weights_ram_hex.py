#!/usr/bin/env python3
"""
Generate Pattern/weights_ram.hex for mamba_weight_storage (285 bytes).

Reads a PyTorch checkpoint; packs per-tensor UINT8 weights + 9-bit sign-mag Z
(one Z per layer, 2-byte slot; RTL uses Z_WIDTH=9).

Usage:
  python gen_weights_ram_hex.py --checkpoint /path/to/check_point_144.pt
  python gen_weights_ram_hex.py --checkpoint ../../check_point_144.pt -o ../Pattern/weights_ram.hex
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

import torch

TOOLS_DIR = Path(__file__).resolve().parent
RUN_DIR = TOOLS_DIR.parent
sys.path.insert(0, str(TOOLS_DIR))

from pack_weight_storage import (  # noqa: E402
    WEIGHT_BYTES,
    pack_weight_storage_from_state_dict,
    write_hex_file,
)


def load_checkpoint(path: Path, d_model: int, d_state: int) -> dict:
    """Load .pt without importing cell7 (no pandas / LUT dependency)."""
    del d_model, d_state  # architecture fixed in pack_weight_storage keys
    raw = torch.load(path, map_location="cpu", weights_only=True)
    if isinstance(raw, dict):
        if "state_dict" in raw:
            return raw["state_dict"]
        # bare state_dict checkpoint
        if "proj_in.weight" in raw:
            return raw
    if hasattr(raw, "state_dict"):
        return raw.state_dict()
    raise SystemExit(f"Unrecognized checkpoint format: {path}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Pack weights_ram.hex (285B, Z9 + bias I12)")
    parser.add_argument(
        "--checkpoint",
        "-c",
        type=Path,
        required=True,
        help="PyTorch .pt checkpoint (e.g. check_point_144.pt)",
    )
    parser.add_argument(
        "--output",
        "-o",
        type=Path,
        default=RUN_DIR / "Pattern" / "weights_ram.hex",
        help="Output .hex path (default: run/Pattern/weights_ram.hex)",
    )
    parser.add_argument("--d-model", type=int, default=8)
    parser.add_argument("--d-state", type=int, default=8)
    args = parser.parse_args()

    if not args.checkpoint.is_file():
        raise SystemExit(f"checkpoint not found: {args.checkpoint}")

    state_dict = load_checkpoint(args.checkpoint, args.d_model, args.d_state)
    blob = pack_weight_storage_from_state_dict(state_dict, args.d_model, args.d_state)
    write_hex_file(blob, args.output)
    print(f"Wrote {args.output} ({WEIGHT_BYTES} bytes, per-tensor Z 9-bit sign-mag)")


if __name__ == "__main__":
    main()
