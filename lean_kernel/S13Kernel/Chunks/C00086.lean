import S13Kernel.Data.Keys

/-! Keys number 5120 to 5191. `data/c/c00086.txt` has sha256 fad3f5b7ff4ae38b330a93316c7cc7b98db9790fbc78987220a5d564eb91dbd0. -/

namespace S13K.Chunks.C00086

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00086.txt"

theorem chk : chkChunk S N 5120 72 ces = true := by decide +kernel

theorem ok : RangeOK S N 5120 5192 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00086
