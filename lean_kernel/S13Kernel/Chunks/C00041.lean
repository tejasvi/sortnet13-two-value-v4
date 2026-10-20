import S13Kernel.Data.Keys

/-! Keys number 2157 to 2207. `data/c/c00041.txt` has sha256 b21c86428f1832801b494958cccecebcae97f2a06f25778990296b79eb30e138. -/

namespace S13K.Chunks.C00041

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00041.txt"

theorem chk : chkChunk S N 2157 51 ces = true := by decide +kernel

theorem ok : RangeOK S N 2157 2208 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00041
