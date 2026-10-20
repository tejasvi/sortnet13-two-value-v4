import S13Kernel.Data.Keys

/-! Keys number 39454 to 39534. `data/c/c00500.txt` has sha256 c14dcf8410d60fa768461384e1cf2ef552145b4f4866779cafa2c645ddf7d6d9. -/

namespace S13K.Chunks.C00500

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00500.txt"

theorem chk : chkChunk S N 39454 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 39454 39535 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00500
