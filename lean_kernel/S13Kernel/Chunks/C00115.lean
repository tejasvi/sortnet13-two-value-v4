import S13Kernel.Data.Keys

/-! Keys number 7130 to 7192. `data/c/c00115.txt` has sha256 a39bd07153e6f464ad764e0b03b6de8b239862076c1135d29d3965b8741dc3e2. -/

namespace S13K.Chunks.C00115

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00115.txt"

theorem chk : chkChunk S N 7130 63 ces = true := by decide +kernel

theorem ok : RangeOK S N 7130 7193 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00115
