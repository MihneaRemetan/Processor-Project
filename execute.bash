#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR"
FILE_LIST="$ROOT_DIR/files_debian.txt"
TMP_FILE_LIST="$ROOT_DIR/.filelist.tmp"

# Normalize CRLF and expand to absolute paths for WSL/bash toolchains
while IFS= read -r line || [ -n "$line" ]; do
	line=${line%$'\r'}
	[ -z "$line" ] && continue
	printf '%s\n' "$ROOT_DIR/$line"
done < "$FILE_LIST" > "$TMP_FILE_LIST"

iverilog -o "$ROOT_DIR/SoC/SoC_tb2.out" -c "$TMP_FILE_LIST" "$ROOT_DIR/SoC/SoC_tb2.v"
vvp "$ROOT_DIR/SoC/SoC_tb2.out"