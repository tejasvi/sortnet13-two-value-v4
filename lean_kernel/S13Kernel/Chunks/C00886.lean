import S13Kernel.Data.Keys

/-! Keys number 76211 to 76308. `data/c/c00886.txt` has sha256 4e82360661d07a159767045df839693418576ea0f7cde267565007eedfa54d92. -/

namespace S13K.Chunks.C00886

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00886.txt"

theorem chk : chkChunk S N 76211 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 76211 76309 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00886
