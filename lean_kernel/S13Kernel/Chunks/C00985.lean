import S13Kernel.Data.Keys

/-! Keys number 86454 to 86546. `data/c/c00985.txt` has sha256 5b232989f6192f6aeb790a4168242857048c7f5a447e007a2c4744597807c9ba. -/

namespace S13K.Chunks.C00985

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00985.txt"

theorem chk : chkChunk S N 86454 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 86454 86547 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00985
