import S13Kernel.Data.Keys

/-! Keys number 26107 to 26203. `data/c/c00350.txt` has sha256 b8d81a8e4c1ec99d2e5bb222f908fde1a088bebf9d70d14c1863809ba1d9abdc. -/

namespace S13K.Chunks.C00350

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00350.txt"

theorem chk : chkChunk S N 26107 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 26107 26204 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00350
