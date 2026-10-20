import S13Kernel.Data.Keys

/-! Keys number 12881 to 12970. `data/c/c00192.txt` has sha256 32f8e0a94e08d24c26a5722be419d878caa099c09ad188a1c4e07a13aea98d1a. -/

namespace S13K.Chunks.C00192

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00192.txt"

theorem chk : chkChunk S N 12881 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 12881 12971 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00192
