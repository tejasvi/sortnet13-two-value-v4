import S13Kernel.Data.Keys

/-! Keys number 36210 to 36296. `data/c/c00465.txt` has sha256 926f004e40c63dbb489d1ca9692c1f0c6ab86c328cc585b5e4fd7b1010ea7e0d. -/

namespace S13K.Chunks.C00465

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00465.txt"

theorem chk : chkChunk S N 36210 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 36210 36297 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00465
