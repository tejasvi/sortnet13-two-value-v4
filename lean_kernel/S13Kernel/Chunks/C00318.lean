import S13Kernel.Data.Keys

/-! Keys number 23275 to 23371. `data/c/c00318.txt` has sha256 a68a58aee4cf4fe5ba60605332387d5e1c3cf4a614a66a1cde238fd8e33d1cc2. -/

namespace S13K.Chunks.C00318

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00318.txt"

theorem chk : chkChunk S N 23275 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 23275 23372 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00318
