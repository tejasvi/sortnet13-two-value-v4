import S13Kernel.Data.Keys

/-! Keys number 73038 to 73126. `data/c/c00855.txt` has sha256 679898ec668f3dc2a1ac6c2e8f9ab714b106eb1368e0cbb5efe4ace920c3c03f. -/

namespace S13K.Chunks.C00855

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00855.txt"

theorem chk : chkChunk S N 73038 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 73038 73127 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00855
