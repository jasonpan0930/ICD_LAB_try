# Simulation (32-pin `mamba_core`: mode / strobe)

## Pattern (`Pattern/`)

- `weights_ram.hex` — 285-byte weight image
- `test_features.hex` — sample features
- `test_mit_ground_truth.hex` — golden labels

## RTL (`run/`)

```bash
source source_run_smoke.sh           # tb_smoke_18118.v, 1 sample
source source_run_batch_18118.sh     # tb_batch_w0_18118.v, 18118 → end
```

## Gate (`Synthesis/`)

Netlist path is hard-coded in each `.sh` — edit if you use `CHIP_syn.v` instead of `CHIP_clkGating_syn.v`.

```bash
source gate_sim_smoke.sh
source gate_sim_batch_18118.sh
```

Gate + SDF example (edit netlist/SDF path in the command as needed):

```bash
vcs -full64 -debug_access+all +v2k -sverilog +incdir+Testbanch \
  +define+GATE_SIM +define+SDF +define+SDF_FILE=\"Netlist/CHIP_clkGating_syn.sdf\" \
  +neg_tchk +notimingcheck +no_notifier +vcs+fsdbon \
  Testbanch/tb_smoke_18118.v ./Netlist/CHIP_clkGating_syn.v \
  fsa0m_a_generic_core_21.lib.src -R
```
