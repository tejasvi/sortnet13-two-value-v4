import S13Kernel.Data.Keys

/-! Keys number 81614 to 81716. `data/c/c00939.txt` has sha256 e31a160cf5f96fbc884be52b1cd312ed8d05e8aa24b2352c3d5009ff4f1f82d6. -/

namespace S13K.Chunks.C00939

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00939.txt"

theorem chk : chkChunk S N 81614 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 81614 81717 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00939
