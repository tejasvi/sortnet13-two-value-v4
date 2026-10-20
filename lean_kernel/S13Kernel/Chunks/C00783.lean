import S13Kernel.Data.Keys

/-! Keys number 66055 to 66147. `data/c/c00783.txt` has sha256 f6a5701263ef2070041b19ef4dc6ee0751ef2b2bab2e6a68058dc403c27badd5. -/

namespace S13K.Chunks.C00783

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00783.txt"

theorem chk : chkChunk S N 66055 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 66055 66148 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00783
