import S13Kernel.Data.Keys

/-! Keys number 58629 to 58723. `data/c/c00708.txt` has sha256 3c705b0921c39c0359cbe2eb8263d4af4a7e90f50ec6db3f303dba8ca658e3dd. -/

namespace S13K.Chunks.C00708

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00708.txt"

theorem chk : chkChunk S N 58629 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 58629 58724 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00708
