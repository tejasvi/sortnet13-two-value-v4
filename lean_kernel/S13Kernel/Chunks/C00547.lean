import S13Kernel.Data.Keys

/-! Keys number 43822 to 43915. `data/c/c00547.txt` has sha256 dc71f940a3f7a14f23db24c01fbdad648118a9f72cac644b5e596bcae1243dd6. -/

namespace S13K.Chunks.C00547

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00547.txt"

theorem chk : chkChunk S N 43822 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 43822 43916 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00547
