import S13Kernel.Data.Keys

/-! Keys number 13068 to 13161. `data/c/c00194.txt` has sha256 c3e03bcd5a2704a446d7adebdc275f9f2070e6d6433b823e0ce8009a8e63d3c2. -/

namespace S13K.Chunks.C00194

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00194.txt"

theorem chk : chkChunk S N 13068 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 13068 13162 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00194
