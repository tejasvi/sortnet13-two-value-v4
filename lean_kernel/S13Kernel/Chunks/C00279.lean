import S13Kernel.Data.Keys

/-! Keys number 20216 to 20283. `data/c/c00279.txt` has sha256 01cec757b71c1d2209d780570e33d4cdf141292b06e55c7e8cab395887df41f2. -/

namespace S13K.Chunks.C00279

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00279.txt"

theorem chk : chkChunk S N 20216 68 ces = true := by decide +kernel

theorem ok : RangeOK S N 20216 20284 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00279
