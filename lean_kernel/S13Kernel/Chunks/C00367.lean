import S13Kernel.Data.Keys

/-! Keys number 27643 to 27742. `data/c/c00367.txt` has sha256 17da7bb2f86cae0f25161743063e1583dd83bdf30e0c2ec7ecb439a4c8a8ea5f. -/

namespace S13K.Chunks.C00367

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00367.txt"

theorem chk : chkChunk S N 27643 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 27643 27743 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00367
