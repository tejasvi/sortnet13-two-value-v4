import S13Kernel.Data.Keys

/-! Keys number 87162 to 87274. `data/c/c00992.txt` has sha256 22c8bd487daf4aecfd25d48273c79ebe70774992fb4b1c739ae81ad6c8478d38. -/

namespace S13K.Chunks.C00992

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00992.txt"

theorem chk : chkChunk S N 87162 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 87162 87275 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00992
