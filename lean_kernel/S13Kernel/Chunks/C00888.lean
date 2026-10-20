import S13Kernel.Data.Keys

/-! Keys number 76410 to 76522. `data/c/c00888.txt` has sha256 06e1a0f1775b58edfe5861c457d67c44aaab70cfd0e4adf8bd3d6e9a6446d42b. -/

namespace S13K.Chunks.C00888

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00888.txt"

theorem chk : chkChunk S N 76410 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 76410 76523 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00888
