import S13Kernel.Data.Keys

/-! Keys number 73775 to 73866. `data/c/c00863.txt` has sha256 1fae07322a8cc2299eb7887892d5ba812e3d2d27f644699f4b0440252e3bf726. -/

namespace S13K.Chunks.C00863

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00863.txt"

theorem chk : chkChunk S N 73775 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 73775 73867 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00863
