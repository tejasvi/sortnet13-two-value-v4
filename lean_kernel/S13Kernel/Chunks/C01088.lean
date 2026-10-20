import S13Kernel.Data.Keys

/-! Keys number 98001 to 98119. `data/c/c01088.txt` has sha256 e33eaf91760cac0e02a3b7262959079076d716df47cf8e9fd2d84ef4249f9d1e. -/

namespace S13K.Chunks.C01088

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01088.txt"

theorem chk : chkChunk S N 98001 119 ces = true := by decide +kernel

theorem ok : RangeOK S N 98001 98120 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01088
