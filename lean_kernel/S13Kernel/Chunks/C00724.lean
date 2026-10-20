import S13Kernel.Data.Keys

/-! Keys number 60355 to 60466. `data/c/c00724.txt` has sha256 4301f5b1d0f426a00f84abdf2f98c0d90ac3c5295e648738c98b89d3efff7729. -/

namespace S13K.Chunks.C00724

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00724.txt"

theorem chk : chkChunk S N 60355 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 60355 60467 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00724
