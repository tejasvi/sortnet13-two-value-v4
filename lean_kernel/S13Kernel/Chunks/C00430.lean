import S13Kernel.Data.Keys

/-! Keys number 33330 to 33403. `data/c/c00430.txt` has sha256 23293ce990c8e4d9101da5a1bbc50c236dc4e7b52aee98af5d921e7f7a240cd4. -/

namespace S13K.Chunks.C00430

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00430.txt"

theorem chk : chkChunk S N 33330 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 33330 33404 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00430
