import S13Kernel.Data.Keys

/-! Keys number 49547 to 49629. `data/c/c00609.txt` has sha256 50702e5b93d33541063f2b6feb39f0d9c0099d76471bfe10fc99b658a661855b. -/

namespace S13K.Chunks.C00609

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00609.txt"

theorem chk : chkChunk S N 49547 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 49547 49630 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00609
