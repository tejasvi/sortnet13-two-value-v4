import S13Kernel.Data.Keys

/-! Keys number 21428 to 21517. `data/c/c00296.txt` has sha256 7552435074508e402382b59538b832247bef0e51e3e1331fa18b69cfbf1f833e. -/

namespace S13K.Chunks.C00296

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00296.txt"

theorem chk : chkChunk S N 21428 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 21428 21518 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00296
