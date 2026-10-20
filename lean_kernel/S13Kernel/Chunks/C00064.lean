import S13Kernel.Data.Keys

/-! Keys number 3553 to 3618. `data/c/c00064.txt` has sha256 d76c64d8f112b8adbbc67232ebb9dc00d545efaa4844708a11340d2e58e3d0a8. -/

namespace S13K.Chunks.C00064

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00064.txt"

theorem chk : chkChunk S N 3553 66 ces = true := by decide +kernel

theorem ok : RangeOK S N 3553 3619 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00064
