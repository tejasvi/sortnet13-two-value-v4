import S13Kernel.Data.Keys

/-! Keys number 63191 to 63290. `data/c/c00753.txt` has sha256 977cb5443ea8bc128621c8f38d519a9f7f9b616fd650300b6d8c86a4b8fb5412. -/

namespace S13K.Chunks.C00753

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00753.txt"

theorem chk : chkChunk S N 63191 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 63191 63291 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00753
