#!/bin/bash
# Regenerate the certificate (data/) and the generated Lean modules (S13Kernel/Data, Chunks, Agg, All)
# from scratch. Deterministic: rerunning it on this tree changes no file.
set -euo pipefail
cd "$(dirname "$0")/.."
g++ -O2 -o gen/certgen gen/certgen.cpp
gen/certgen 13 8 gen/keys_13_8.txt gen/certs_13_8.txt
python3 gen/mkmods.py gen/keys_13_8.txt gen/certs_13_8.txt 30000
