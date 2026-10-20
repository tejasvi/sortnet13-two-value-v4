import S13Kernel.Data.Keys

/-! Keys number 54351 to 54454. `data/c/c00662.txt` has sha256 1983252e9f476f5de7f0b283a2dd2b47ec7b067a326e265ba1ebc27a900764b9. -/

namespace S13K.Chunks.C00662

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00662.txt"

theorem chk : chkChunk S N 54351 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 54351 54455 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00662
