import S13Kernel.Data.Keys

/-! Keys number 68195 to 68285. `data/c/c00806.txt` has sha256 69a8e6bff5deded0f3765836aa2453bf60056acbec61c7e0ad1d9409fc187cfc. -/

namespace S13K.Chunks.C00806

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00806.txt"

theorem chk : chkChunk S N 68195 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 68195 68286 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00806
