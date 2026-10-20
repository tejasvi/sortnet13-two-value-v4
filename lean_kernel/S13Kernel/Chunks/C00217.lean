import S13Kernel.Data.Keys

/-! Keys number 14962 to 15021. `data/c/c00217.txt` has sha256 4c3ae0bc2a08c5e460eac83e87d45d5222c787d61364488c1dd805694e89c7d6. -/

namespace S13K.Chunks.C00217

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00217.txt"

theorem chk : chkChunk S N 14962 60 ces = true := by decide +kernel

theorem ok : RangeOK S N 14962 15022 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00217
