import S13Kernel.Data.Keys

/-! Keys number 25388 to 25449. `data/c/c00341.txt` has sha256 ae8c1a0b9822b4b653a347c7fcc0a3decd28c07dc6fd2db15ab0101944cc0b74. -/

namespace S13K.Chunks.C00341

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00341.txt"

theorem chk : chkChunk S N 25388 62 ces = true := by decide +kernel

theorem ok : RangeOK S N 25388 25450 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00341
