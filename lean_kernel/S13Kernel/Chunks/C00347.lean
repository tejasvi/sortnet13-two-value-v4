import S13Kernel.Data.Keys

/-! Keys number 25850 to 25918. `data/c/c00347.txt` has sha256 7b3e21e73e4fd485f66ab0a2d02723b3b4ebd6a885160cf41c487871901e3987. -/

namespace S13K.Chunks.C00347

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00347.txt"

theorem chk : chkChunk S N 25850 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 25850 25919 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00347
