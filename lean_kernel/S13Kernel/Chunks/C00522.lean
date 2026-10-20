import S13Kernel.Data.Keys

/-! Keys number 41356 to 41442. `data/c/c00522.txt` has sha256 4dd09d5d1c55dc6d63cf29cb530616601febb42ed4e6f6aa7c6d58edc7e39536. -/

namespace S13K.Chunks.C00522

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00522.txt"

theorem chk : chkChunk S N 41356 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 41356 41443 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00522
