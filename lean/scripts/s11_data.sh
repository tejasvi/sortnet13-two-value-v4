#!/bin/bash
# Generate the certificate data for S(11) >= 35 from Harder's certificate.
#
#   scripts/s11_data.sh proof_cert_11.bin[.zst]
#
# Harder's certificate: doi:10.5281/zenodo.4108365 (proof_cert_11.bin.zst); the SHA-256 of the
# uncompressed file is 7fe9f5cd694714bf83da0bcab162a290eb076ad4257265507a74cea8fab85b7e.
# Writes data/s11/cNN.s7 (33 files, 2.2 GB) and data/s11/manifest.txt, then regenerates
# S11Data/*.lean (whose FNV-1a pins must match the committed ones).
set -euo pipefail
cd "$(dirname "$0")/.."
IN="$1"
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT
if [[ "$IN" == *.zst ]]; then zstd -d -c "$IN" > "$WORK/proof_cert_11.bin"; IN="$WORK/proof_cert_11.bin"; fi
echo "sha256 of the certificate:"; sha256sum "$IN"
c++ -O2 -o "$WORK/convert" tools/convert.cpp
c++ -O2 -o "$WORK/split" tools/split.cpp
"$WORK/convert" "$IN" "$WORK/cert11.s7"
mkdir -p data/s11
"$WORK/split" "$WORK/cert11.s7" data/s11 > data/s11/manifest.txt
python3 scripts/gen_s11_modules.py
git diff --stat -- S11Data || true
