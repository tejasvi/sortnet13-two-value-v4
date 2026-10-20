import S13Kernel.Data.Keys

/-! Keys number 63006 to 63095. `data/c/c00751.txt` has sha256 b5b754aab625d15a00e31f72af17976ec841e2b71d4a2cb050d032e002f2112f. -/

namespace S13K.Chunks.C00751

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00751.txt"

theorem chk : chkChunk S N 63006 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 63006 63096 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00751
