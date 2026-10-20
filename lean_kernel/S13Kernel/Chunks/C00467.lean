import S13Kernel.Data.Keys

/-! Keys number 36385 to 36479. `data/c/c00467.txt` has sha256 4074597d6cca8b6a033220337fe2ba888c2455671a8869893f683f831d83f7eb. -/

namespace S13K.Chunks.C00467

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00467.txt"

theorem chk : chkChunk S N 36385 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 36385 36480 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00467
