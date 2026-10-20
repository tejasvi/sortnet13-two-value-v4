import S13Kernel.Data.Keys

/-! Keys number 28420 to 28508. `data/c/c00375.txt` has sha256 31abbd0699d6529edb08450ce474acb2c2643be225b92c903506ea4fefe5df43. -/

namespace S13K.Chunks.C00375

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00375.txt"

theorem chk : chkChunk S N 28420 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 28420 28509 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00375
