import S13Kernel.Data.Keys

/-! Keys number 6731 to 6817. `data/c/c00110.txt` has sha256 8e54a3abbb9b3012aaeb85bf822e9b7ae4cef0f40c67ed0195602fa4acb13149. -/

namespace S13K.Chunks.C00110

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00110.txt"

theorem chk : chkChunk S N 6731 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 6731 6818 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00110
