import S13Kernel.Data.Keys

/-! Keys number 38770 to 38863. `data/c/c00492.txt` has sha256 8f73649e6f38e8aacf881fde0d63754f55e5bb1ad271ec941313fc1dd83f5da7. -/

namespace S13K.Chunks.C00492

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00492.txt"

theorem chk : chkChunk S N 38770 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 38770 38864 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00492
