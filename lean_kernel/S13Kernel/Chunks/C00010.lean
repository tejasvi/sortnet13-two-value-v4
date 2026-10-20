import S13Kernel.Data.Keys

/-! Keys number 405 to 454. `data/c/c00010.txt` has sha256 4c0562edd8e125b214cbb5457a4719d4167b6a18e80312022fc8bd6fdf613c40. -/

namespace S13K.Chunks.C00010

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00010.txt"

theorem chk : chkChunk S N 405 50 ces = true := by decide +kernel

theorem ok : RangeOK S N 405 455 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00010
