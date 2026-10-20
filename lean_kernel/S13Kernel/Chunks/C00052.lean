import S13Kernel.Data.Keys

/-! Keys number 2735 to 2808. `data/c/c00052.txt` has sha256 4b0346538ca0745340871b7b24dd6221eefa7b38c711b67c9ee2ffd826c86784. -/

namespace S13K.Chunks.C00052

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00052.txt"

theorem chk : chkChunk S N 2735 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 2735 2809 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00052
