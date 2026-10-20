import S13Kernel.Data.Keys

/-! Keys number 85206 to 85321. `data/c/c00973.txt` has sha256 93360a0cde5e060c07d1c277747a4d38deba11585c0ed11d09f5434f4db05f95. -/

namespace S13K.Chunks.C00973

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00973.txt"

theorem chk : chkChunk S N 85206 116 ces = true := by decide +kernel

theorem ok : RangeOK S N 85206 85322 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00973
