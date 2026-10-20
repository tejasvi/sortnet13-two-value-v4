import S13Kernel.Data.Keys

/-! Keys number 57214 to 57304. `data/c/c00693.txt` has sha256 b6e4cd08aba76fe42e420632228e4e413b5639b855e4c16f84dacf8b269c22c7. -/

namespace S13K.Chunks.C00693

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00693.txt"

theorem chk : chkChunk S N 57214 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 57214 57305 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00693
