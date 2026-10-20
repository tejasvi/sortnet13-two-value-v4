import S13Kernel.Data.Keys

/-! Keys number 15191 to 15272. `data/c/c00220.txt` has sha256 efeca443c85eea35a0f52943e4103790019803ba3c7f61e4acad865e230b610b. -/

namespace S13K.Chunks.C00220

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00220.txt"

theorem chk : chkChunk S N 15191 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 15191 15273 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00220
