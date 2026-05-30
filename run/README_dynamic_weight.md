# Simulation flow (32-pin `mamba_core`: mode / strobe)

## Top-level interface

| Signal | Role |
|--------|------|
| `mode=1` | Weight-load: each `strobe` writes `w_data[7:0]` to auto-increment address |
| `mode=0` | Inference: `strobe` = sample valid, `i_data[15:0]` = ECG feature |
| `o_ready` / `o_valid` / `o_class` | Handshake and classification result |

## Pattern files (`Pattern/`)

| File | Role |
|------|------|
| `weights_ram.hex` | 285 bytes weight image |
| `test_features.hex` | All sample features |
| `test_mit_ground_truth.hex` | 2-bit golden class per sample |

Regenerate weights: `python3 tools/gen_weights_ram_hex.py`

## Testbenches (`Testbanch/`)

| File | Description |
|------|-------------|
| `tb_smoke_18118.v` | **1 sample** (18118) — quick smoke test |
| `tb_batch_w0_18118.v` | Batch eval, samples **18118 → end** |
| `tb_batch_body.inc.v` | Shared batch logic |
| `tb_define.vh` | Clock / FSDB options |

## RTL sim (from `run/`)

```bash
source source_run_smoke.sh              # 1 sample
source source_run_batch_18118.sh        # 18118 → end
source source_run_smoke.sh +fsdb +fsdbfile=wave.fsdb
```

## Gate-level sim (from `Synthesis/`)

```bash
cp -r ../run/Pattern .
bash synthesis.sh

source gate_sim_smoke.sh
source gate_sim_batch_18118.sh

setenv GATE_SDF 1; source gate_sim_smoke.sh   # optional SDF
```
