import S13Kernel.Data.Keys

/-! Keys number 51507 to 51598. `data/c/c00632.txt` has sha256 2debb40b1bea374082378c6415fc28b76465c4774d3e83be6f43f25092c39ce4. -/

namespace S13K.Chunks.C00632

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00632.txt"

theorem chk : chkChunk S N 51507 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 51507 51599 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00632
