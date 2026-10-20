import S13Kernel.Data.Keys

/-! Keys number 34013 to 34089. `data/c/c00439.txt` has sha256 0d148050da3dd891421044cb9e286f544829120b7bd15e42b184bf837b6f59da. -/

namespace S13K.Chunks.C00439

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00439.txt"

theorem chk : chkChunk S N 34013 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 34013 34090 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00439
