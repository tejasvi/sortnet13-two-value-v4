import S13Kernel.Data.Keys

/-! Keys number 1529 to 1587. `data/c/c00031.txt` has sha256 abbf1710a98f08f32e5991d9de76a52c6fd72c68256ebce44d2da02d0c5ea4b7. -/

namespace S13K.Chunks.C00031

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00031.txt"

theorem chk : chkChunk S N 1529 59 ces = true := by decide +kernel

theorem ok : RangeOK S N 1529 1588 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00031
