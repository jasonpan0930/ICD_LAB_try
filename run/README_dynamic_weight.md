# Dynamic weight loading (run flow)

This document describes how weights are supplied to `mamba_core` without baking them into RTL compile, and how to simulate it.

## Reset: `rst_n` vs `rst_weights_n`

- **`rst_n`**: Resets the **core FSM** (`mamba_core` sequential logic: `step_cnt`, `h_reg`, `y_pool_reg`, `o_valid`, etc.) and the **datapath** (`mamba_datapath_new` internal registers). Use **once per inference sample** so each ECG starts from a clean hidden state.
- **`rst_weights_n`**: Resets **only** `mamba_weight_storage` (all weight / constant registers to zero). Assert low when you want to discard bus-loaded weights; otherwise keep it high so **one 369-byte bus load** can be reused across many samples while you only pulse **`rst_n`** between samples.
- **Legacy testbenches** that do not load weights over the bus tie `rst_weights_n` to `rst_n` so behavior matches a single global reset.

## RTL behavior

- **`mamba_weight_storage`** holds all trainable constants as registers. On **`rst_weights_n` low** (async), every weight register is cleared to **zero**. **`rst_n` does not clear weights.** There is **no** `` `include `` of weight constants in the `run/Core` simulation RTL.
- **`run/tools/mamba_datapath_params.vh`** is a **reference only** copy of the original weight/bias constants (for humans, scripts, and optional legacy `` `include `` in `Synthesis/Core/mamba_datapath.v`). Design Compiler resolves it via `search_path` in `Synthesis/synthesis.tcl` (`../run/tools`).
- Before first meaningful inference, assert **`rst_weights_n` low then high**, **bus-write 369 bytes**, then release **`rst_n`**. Between samples, pulse **`rst_n` only** if weights are already loaded.
- Load port: **`w_we`** (strobe), **`w_addr`** byte `0..368`, **`w_data`** 8-bit (see `mamba_weight_storage.v` map).
- **`mamba_core`** exposes `rst_n`, **`rst_weights_n`**, `w_we`, `w_addr`, `w_data` (width `ADDR_WIDTH`, default 9).

## Pattern files

| File | Role |
|------|------|
| `Pattern/weights_ram.hex` | 369 lines, one hex byte per line, same byte order as `w_addr` in `mamba_weight_storage`. |
| `Pattern/test_features.hex` | Features for all test samples. |
| `Pattern/test_mit_ground_truth.hex` | 2-bit class per sample (golden). |

Regenerate `weights_ram.hex` from the Python reference (constants aligned with `run/tools/mamba_datapath_params.vh`):

```bash
python3 tools/gen_weights_ram_hex.py
```

(Run from the `run/` directory.)

## Testbenches

### `Testbanch/tb_mit_sick.v` (batch MIT-BIH, `source_run.sh`)

Weights are **bus-loaded once** after `rst_weights_n` / `rst_n` power-up; each sample only **pulses `rst_n`** (datapath + FSM) before feeding 187 beats—**no per-sample weight reload**.

```bash
source source_run.sh
```

### `Testbanch/tb_mit_sick_weight_dyn.v` (quick, default 100 samples)

- **Phase 1–2**: After POR (`rst_weights_n` / `rst_n`), **bus-load once**; each of `SAMPLE_COUNT` samples: **`rst_n` only → feed** vs golden.
- **Phase 3–4**: XOR `weight_mem`, **bus-reload once** into DUT, same per-sample **`rst_n` → feed**; compare vs Phase 1–2 baseline.
- **Phase 5**: `$readmemh`, **bus-reload once**, one-sample **`rst_n` → feed** check.

Compile/run (CIC environment):

```bash
source source_run_tb_weight_dyn.sh
```

### `Testbanch/tb_mit_sick_weight_dyn_full.v` (18118 → end, single pass)

- **`$readmemh`** then **`rst_weights_n` deassert → bus-load 369B once → `rst_n` high**; for each sample **`rst_n` pulse only → feed** (weights stay loaded). **Every sample prints one `[WEIGHT_TAIL] OK` or `NG` line.**

```bash
source source_run_tb_weight_dyn_full.sh
```

## Compile-time pattern path overrides

`tb_mit_sick_weight_dyn.v` and `tb_mit_sick_weight_dyn_full.v` use `` `define `` defaults for `$readmemh` paths. Override at **VCS compile** time, for example:

```bash
vcs ... +define+PATTERN_WEIGHTS_HEX=\"/path/to/other_weights.hex\"
```

Similarly: `PATTERN_FEATURES_HEX`, `PATTERN_GOLDEN_HEX`. Escape quotes as required by your shell. (`tb_mit_sick.v` uses fixed paths unless you edit it.)

## Notes

- Any TB that relies on golden vectors **must** load weights after **`rst_weights_n`** release; otherwise the DUT runs with all-zero weights.
- Legacy **`Synthesis/Core/mamba_datapath.v`** still `` `include "mamba_datapath_params.vh"``; the file is resolved from **`run/tools/`** when using the updated `synthesis.tcl` / `synthesis_quick.tcl` `search_path`. The main synthesis flow uses **`mamba_datapath_new.v`**, which does not include the params header.
