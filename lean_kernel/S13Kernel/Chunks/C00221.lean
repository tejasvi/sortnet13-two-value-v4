import S13Kernel.Data.Keys

/-! Keys number 15273 to 15342. `data/c/c00221.txt` has sha256 a14894b9389fd83cd62cbafd041750bd6240ba12cf95c643378085dbdc78969a. -/

namespace S13K.Chunks.C00221

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00221.txt"

theorem chk : chkChunk S N 15273 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 15273 15343 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00221
