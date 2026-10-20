import S13Kernel.Data.Keys

/-! Keys number 43313 to 43424. `data/c/c00542.txt` has sha256 3ffdb6e55bafa59a3839796cd29a9b7a7fd37d1ee8babe8232c52a9e9499c721. -/

namespace S13K.Chunks.C00542

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00542.txt"

theorem chk : chkChunk S N 43313 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 43313 43425 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00542
