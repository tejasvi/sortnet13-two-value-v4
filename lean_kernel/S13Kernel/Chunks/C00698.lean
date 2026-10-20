import S13Kernel.Data.Keys

/-! Keys number 57694 to 57795. `data/c/c00698.txt` has sha256 1c3c96e3d126c537069aef9cf3a4f9a41d49d82f3022c226a0a8f3a2d36d2833. -/

namespace S13K.Chunks.C00698

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00698.txt"

theorem chk : chkChunk S N 57694 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 57694 57796 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00698
