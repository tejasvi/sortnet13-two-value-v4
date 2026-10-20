import S13Kernel.Data.Keys

/-! Keys number 15616 to 15709. `data/c/c00225.txt` has sha256 3d2ce93f342639dd82710854b7428fa958b3762067c2a1a815d6e4ae83c0c07d. -/

namespace S13K.Chunks.C00225

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00225.txt"

theorem chk : chkChunk S N 15616 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 15616 15710 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00225
