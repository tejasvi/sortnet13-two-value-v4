import S13Kernel.Data.Keys

/-! Keys number 62834 to 62920. `data/c/c00749.txt` has sha256 351e8cc9a183ab5d63f4a00e15ef6a674091d34e6b1aedcefe8edf5aae20206a. -/

namespace S13K.Chunks.C00749

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00749.txt"

theorem chk : chkChunk S N 62834 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 62834 62921 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00749
