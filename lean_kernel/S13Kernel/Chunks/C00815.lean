import S13Kernel.Data.Keys

/-! Keys number 69084 to 69189. `data/c/c00815.txt` has sha256 49dfc48257c7d09cd4a24bf61e18ffda1d50bce4012f099ec3a1ea27f7f4e74a. -/

namespace S13K.Chunks.C00815

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00815.txt"

theorem chk : chkChunk S N 69084 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 69084 69190 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00815
