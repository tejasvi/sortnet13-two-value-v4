import S13Kernel.Data.Keys

/-! Keys number 3695 to 3770. `data/c/c00066.txt` has sha256 f13424223f3733baa41df63d9ab9148cc42e525a7f5b0fe130ff3cc0d0129997. -/

namespace S13K.Chunks.C00066

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00066.txt"

theorem chk : chkChunk S N 3695 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 3695 3771 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00066
