import S13Kernel.Data.Keys

/-! Keys number 3972 to 4045. `data/c/c00070.txt` has sha256 edf33a6183a817a49376810c220f56fda1deaa7ed051c67d15f48551344786f8. -/

namespace S13K.Chunks.C00070

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00070.txt"

theorem chk : chkChunk S N 3972 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 3972 4046 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00070
