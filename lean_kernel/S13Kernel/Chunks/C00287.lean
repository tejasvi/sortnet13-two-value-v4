import S13Kernel.Data.Keys

/-! Keys number 20766 to 20836. `data/c/c00287.txt` has sha256 33341f38b75cf83351073d62400bc0ca908c0f8ed166987a666396a75009984b. -/

namespace S13K.Chunks.C00287

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00287.txt"

theorem chk : chkChunk S N 20766 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 20766 20837 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00287
