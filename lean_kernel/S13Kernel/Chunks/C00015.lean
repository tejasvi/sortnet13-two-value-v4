import S13Kernel.Data.Keys

/-! Keys number 669 to 713. `data/c/c00015.txt` has sha256 378ca24f134de877dbe66a6dfba86ecb64372c2a90c19e14b856e8c2efcf1bda. -/

namespace S13K.Chunks.C00015

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00015.txt"

theorem chk : chkChunk S N 669 45 ces = true := by decide +kernel

theorem ok : RangeOK S N 669 714 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00015
