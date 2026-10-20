import S13Kernel.Data.Keys

/-! Keys number 25324 to 25387. `data/c/c00340.txt` has sha256 7c5b3ce7ddd681d2a51100e770d8c0f02300ba4402d8961944bb03e7491a67da. -/

namespace S13K.Chunks.C00340

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00340.txt"

theorem chk : chkChunk S N 25324 64 ces = true := by decide +kernel

theorem ok : RangeOK S N 25324 25388 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00340
