#!/usr/bin/env python3
"""Generate Pattern/weights_ram_143.hex from checkpoint (same 285B map as weights_ram.hex)."""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

TOOLS_DIR = Path(__file__).resolve().parent
RUN_DIR = TOOLS_DIR.parent
sys.path.insert(0, str(TOOLS_DIR))

from gen_weights_ram_hex import load_checkpoint  # noqa: E402
from pack_weight_storage import pack_weight_storage_from_state_dict, write_hex_file, WEIGHT_BYTES  # noqa: E402


def main() -> None:
    default_ckpt = RUN_DIR.parent / "check_point_144.pt"
    parser = argparse.ArgumentParser(description="Pack weights_ram_143.hex (285B)")
    parser.add_argument("--checkpoint", "-c", type=Path, default=default_ckpt)
    parser.add_argument(
        "--output",
        "-o",
        type=Path,
        default=RUN_DIR / "Pattern" / "weights_ram_143.hex",
    )
    parser.add_argument("--d-model", type=int, default=8)
    parser.add_argument("--d-state", type=int, default=8)
    args = parser.parse_args()

    if not args.checkpoint.is_file():
        raise SystemExit(
            f"checkpoint not found: {args.checkpoint}\n"
            "  pass --checkpoint /path/to/check_point_144.pt"
        )

    state_dict = load_checkpoint(args.checkpoint, args.d_model, args.d_state)
    blob = pack_weight_storage_from_state_dict(state_dict, args.d_model, args.d_state)
    write_hex_file(blob, args.output)
    print(f"Wrote {args.output} ({WEIGHT_BYTES} bytes, per-tensor Z 9-bit sign-mag)")


if __name__ == "__main__":
    main()
