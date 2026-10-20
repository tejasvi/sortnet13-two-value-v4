import S13Kernel.Data.Keys

/-! Keys number 17663 to 17738. `data/c/c00248.txt` has sha256 9d3338292926358a9436bb477bc31c9e98ab08ea3f25ec36f5028ff60940612f. -/

namespace S13K.Chunks.C00248

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00248.txt"

theorem chk : chkChunk S N 17663 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 17663 17739 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00248
