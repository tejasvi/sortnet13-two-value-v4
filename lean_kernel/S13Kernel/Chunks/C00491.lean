import S13Kernel.Data.Keys

/-! Keys number 38691 to 38769. `data/c/c00491.txt` has sha256 20914ca9d20f0dbd4a774c2e489b14f8eca27b9800f771a5524f495b471b43f4. -/

namespace S13K.Chunks.C00491

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00491.txt"

theorem chk : chkChunk S N 38691 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 38691 38770 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00491
