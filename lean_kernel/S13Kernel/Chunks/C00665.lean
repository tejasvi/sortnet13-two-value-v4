import S13Kernel.Data.Keys

/-! Keys number 54697 to 54822. `data/c/c00665.txt` has sha256 fb6745f785bf54a12aa2afc1ca751e679bdcdffb3178e8539da4284d91ebe07f. -/

namespace S13K.Chunks.C00665

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00665.txt"

theorem chk : chkChunk S N 54697 126 ces = true := by decide +kernel

theorem ok : RangeOK S N 54697 54823 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00665
