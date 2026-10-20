import S13Kernel.Data.Keys

/-! Keys number 25540 to 25607. `data/c/c00343.txt` has sha256 db8f3da47241f333aee95df874feea5861bfbebf9bfdd67853f932b7be252b30. -/

namespace S13K.Chunks.C00343

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00343.txt"

theorem chk : chkChunk S N 25540 68 ces = true := by decide +kernel

theorem ok : RangeOK S N 25540 25608 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00343
