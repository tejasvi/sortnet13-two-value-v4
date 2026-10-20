import S13Kernel.Data.Keys

/-! Keys number 15022 to 15108. `data/c/c00218.txt` has sha256 31487c16bd7b8b5fd6d5f48f824ecdd48225d3dac3d5733245fc18d8f8b21a61. -/

namespace S13K.Chunks.C00218

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00218.txt"

theorem chk : chkChunk S N 15022 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 15022 15109 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00218
