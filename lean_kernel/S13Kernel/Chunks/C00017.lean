import S13Kernel.Data.Keys

/-! Keys number 771 to 831. `data/c/c00017.txt` has sha256 05e0a9992d33eda496ca1c47559e1b0b6fbbfff77f56050ef60efedd6ea291b5. -/

namespace S13K.Chunks.C00017

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00017.txt"

theorem chk : chkChunk S N 771 61 ces = true := by decide +kernel

theorem ok : RangeOK S N 771 832 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00017
