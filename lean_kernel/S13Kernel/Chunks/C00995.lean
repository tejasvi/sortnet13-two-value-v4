import S13Kernel.Data.Keys

/-! Keys number 87473 to 87565. `data/c/c00995.txt` has sha256 0e2e45f9cb44bdafaf46adc7cff49d6f5afe538bf38aa8732104a243fca33c08. -/

namespace S13K.Chunks.C00995

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00995.txt"

theorem chk : chkChunk S N 87473 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 87473 87566 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00995
