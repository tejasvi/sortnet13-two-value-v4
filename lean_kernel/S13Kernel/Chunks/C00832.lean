import S13Kernel.Data.Keys

/-! Keys number 70804 to 70898. `data/c/c00832.txt` has sha256 6ea10d6adb98482281809f0f7ff4f26b582ecef2be2d98d0a83f258ccbdf9470. -/

namespace S13K.Chunks.C00832

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00832.txt"

theorem chk : chkChunk S N 70804 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 70804 70899 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00832
