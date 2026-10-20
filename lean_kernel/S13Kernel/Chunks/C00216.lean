import S13Kernel.Data.Keys

/-! Keys number 14894 to 14961. `data/c/c00216.txt` has sha256 47f8572c571e227a7e92cc150101e131e6d494affaef1cd045dd5dc891eab49a. -/

namespace S13K.Chunks.C00216

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00216.txt"

theorem chk : chkChunk S N 14894 68 ces = true := by decide +kernel

theorem ok : RangeOK S N 14894 14962 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00216
