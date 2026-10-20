import S13Kernel.Data.Keys

/-! Keys number 84172 to 84278. `data/c/c00963.txt` has sha256 8be971a8a01dba8f7d5af34940f832ed54645a99d5d0fdbc56968b6bf8c70026. -/

namespace S13K.Chunks.C00963

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00963.txt"

theorem chk : chkChunk S N 84172 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 84172 84279 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00963
