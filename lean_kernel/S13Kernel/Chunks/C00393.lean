import S13Kernel.Data.Keys

/-! Keys number 30079 to 30164. `data/c/c00393.txt` has sha256 191e6b9f03aac7c12dc89f4f7b0aa8c1b5a6c3826ad32f6bff9dd3bfb3f2e73a. -/

namespace S13K.Chunks.C00393

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00393.txt"

theorem chk : chkChunk S N 30079 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 30079 30165 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00393
