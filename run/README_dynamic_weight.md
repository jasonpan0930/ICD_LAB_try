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
| `weights_ram.hex` | 285 bytes, default weight set |
| `weights_ram_143.hex` | Alternate weight set |
| `test_features.hex` | All sample features |
| `test_mit_ground_truth.hex` | 2-bit golden class per sample |

Regenerate weights:

```bash
python3 tools/gen_weights_ram_hex.py
python3 tools/gen_weights_ram_143_hex.py
```

## Testbenches (`Testbanch/`)

| File | Description |
|------|-------------|
| `tb_smoke_18118.v` | **1 sample** (18118) — quick RTL / gate smoke test |
| `tb_batch_w0_18118.v` | Batch with `weights_ram.hex`, samples **18118 → end** |
| `tb_batch_w0_full.v` | Batch with `weights_ram.hex`, samples **0 → end** |
| `tb_batch_w143_18118.v` | Batch with `weights_ram_143.hex`, from **18118** |
| `tb_batch_w143_full.v` | Batch with `weights_ram_143.hex`, from **0** |
| `tb_batch_body.inc.v` | Shared batch logic (included by `tb_batch_*.v`) |
| `tb_define.vh` | Clock / FSDB compile-time options |

## Run scripts (from `run/`)

| Script | TB | Use case |
|--------|-----|----------|
| `source_run_smoke.sh` | `tb_smoke_18118.v` | Fast sanity check (1 sample) |
| `source_run_batch_18118.sh` | `tb_batch_w0_18118.v` | Main batch eval from 18118 |
| `source_run_batch_full.sh` | `tb_batch_w0_full.v` | Full dataset batch eval |
| `source_run_batch_w143_18118.sh` | `tb_batch_w143_18118.v` | w143 weights, from 18118 |
| `source_run_batch_w143_full.sh` | `tb_batch_w143_full.v` | w143 weights, full dataset |

```bash
source source_run_smoke.sh
source source_run_batch_18118.sh
source source_run_smoke.sh +fsdb +fsdbfile=wave.fsdb
```

## Gate-level sim (from `Synthesis/`)

After `bash synthesis.sh` produces `Netlist/CHIP_syn.v`:

```bash
cp -r ../run/Pattern .

# smoke (1 sample)
source gate_sim_smoke.sh

# batch (same TBs as RTL run/)
source gate_sim_batch_18118.sh
source gate_sim_batch_full.sh
source gate_sim_batch_w143_18118.sh
source gate_sim_batch_w143_full.sh

# or pass TB name directly
source gate_sim.sh tb_batch_w0_18118.v

# optional SDF timing
setenv GATE_SDF 1; source gate_sim_smoke.sh
```
