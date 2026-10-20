import S13Kernel.Data.Keys

/-! Keys number 37426 to 37524. `data/c/c00479.txt` has sha256 58f5cb92609d15a1f7bac1da9f0bbf3e1f4acdae830ea88e064024c55509189c. -/

namespace S13K.Chunks.C00479

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00479.txt"

theorem chk : chkChunk S N 37426 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 37426 37525 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00479
