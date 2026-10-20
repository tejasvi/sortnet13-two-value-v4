import S13Kernel.Data.Keys

/-! Keys number 33616 to 33701. `data/c/c00434.txt` has sha256 09923f70c58517a758783dfeefdb0718822e7c2ccd2db322923ac653c2da9292. -/

namespace S13K.Chunks.C00434

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00434.txt"

theorem chk : chkChunk S N 33616 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 33616 33702 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00434
