import S13Kernel.Data.Keys

/-! Keys number 86052 to 86150. `data/c/c00981.txt` has sha256 5179edfaf88d60859ec07b184fdfc449256bdddc06fa546c1ab63c3f7c0474c2. -/

namespace S13K.Chunks.C00981

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00981.txt"

theorem chk : chkChunk S N 86052 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 86052 86151 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00981
