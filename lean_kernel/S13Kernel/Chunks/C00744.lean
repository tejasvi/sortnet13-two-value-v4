import S13Kernel.Data.Keys

/-! Keys number 62372 to 62473. `data/c/c00744.txt` has sha256 f241a663c6ce89e9e1da378bddb430932e40d5598cd9732eed7ed02e079ec668. -/

namespace S13K.Chunks.C00744

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00744.txt"

theorem chk : chkChunk S N 62372 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 62372 62474 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00744
