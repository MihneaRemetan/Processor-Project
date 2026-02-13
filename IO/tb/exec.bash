#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/../.."
FILE_LIST="$ROOT_DIR/files_debian.txt"
OUT_BIN="$SCRIPT_DIR/lic"

iverilog -o "$OUT_BIN" "$ROOT_DIR/IO/io_tb.v" -c "$FILE_LIST"
vvp "$OUT_BIN"
gtkwave "$SCRIPT_DIR/wave.gtkw"