import S13Kernel.Data.Keys

/-! Keys number 21845 to 21920. `data/c/c00301.txt` has sha256 05c725ef077b9a6b501416d9cfe5ec36f209bd88150b77b4bcda48a32d11d9b0. -/

namespace S13K.Chunks.C00301

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00301.txt"

theorem chk : chkChunk S N 21845 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 21845 21921 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00301
