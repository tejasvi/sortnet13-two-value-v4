import S13Kernel.Data.Keys

/-! Keys number 90273 to 90376. `data/c/c01020.txt` has sha256 ca3bb25208ce605f0ae2fe1befd51edbeccc2b695b6e32c9ed46f7152042f4fb. -/

namespace S13K.Chunks.C01020

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01020.txt"

theorem chk : chkChunk S N 90273 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 90273 90377 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01020
