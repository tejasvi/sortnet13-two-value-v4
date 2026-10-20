import S13Kernel.Data.Keys

/-! Keys number 75517 to 75625. `data/c/c00880.txt` has sha256 1d4a5da776578899d6a7db6d43647fc8d7dd854c30e4cf8b4af5cdeff56a2a90. -/

namespace S13K.Chunks.C00880

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00880.txt"

theorem chk : chkChunk S N 75517 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 75517 75626 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00880
