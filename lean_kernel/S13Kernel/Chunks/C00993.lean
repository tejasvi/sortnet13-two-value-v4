import S13Kernel.Data.Keys

/-! Keys number 87275 to 87374. `data/c/c00993.txt` has sha256 e8599b6bfc8b8496789d8c7e1c01b7d041b023ef21ac034deb4c43f9cf675933. -/

namespace S13K.Chunks.C00993

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00993.txt"

theorem chk : chkChunk S N 87275 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 87275 87375 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00993
