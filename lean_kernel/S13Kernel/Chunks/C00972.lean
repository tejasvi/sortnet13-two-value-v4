import S13Kernel.Data.Keys

/-! Keys number 85099 to 85205. `data/c/c00972.txt` has sha256 c8104b337aac829734cf795b6aaffc1cdc2d7826eb9b5a7e3096cc079e563e0d. -/

namespace S13K.Chunks.C00972

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00972.txt"

theorem chk : chkChunk S N 85099 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 85099 85206 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00972
