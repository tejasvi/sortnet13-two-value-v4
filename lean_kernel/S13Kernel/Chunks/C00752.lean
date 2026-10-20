import S13Kernel.Data.Keys

/-! Keys number 63096 to 63190. `data/c/c00752.txt` has sha256 f29415cbb6ca217ce47a90393be419de452c9dd54182733e9b8d038cd76acf65. -/

namespace S13K.Chunks.C00752

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00752.txt"

theorem chk : chkChunk S N 63096 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 63096 63191 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00752
