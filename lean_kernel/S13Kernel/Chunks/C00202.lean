import S13Kernel.Data.Keys

/-! Keys number 13774 to 13843. `data/c/c00202.txt` has sha256 a2a5eb46f7da7f359b70ea2a223edf52cbc288dc347cc99e413c8128166239eb. -/

namespace S13K.Chunks.C00202

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00202.txt"

theorem chk : chkChunk S N 13774 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 13774 13844 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00202
