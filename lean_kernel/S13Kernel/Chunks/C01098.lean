import S13Kernel.Data.Keys

/-! Keys number 99230 to 99356. `data/c/c01098.txt` has sha256 f359a29cf041606afbde8b4ffd94c7e2eb9c52f0b6a5e8f8e7fd821c92526415. -/

namespace S13K.Chunks.C01098

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01098.txt"

theorem chk : chkChunk S N 99230 127 ces = true := by decide +kernel

theorem ok : RangeOK S N 99230 99357 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01098
