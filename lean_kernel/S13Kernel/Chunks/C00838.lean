import S13Kernel.Data.Keys

/-! Keys number 71444 to 71539. `data/c/c00838.txt` has sha256 9a31d39976a94a68407e2e387da8a58cbca0e329c1bc50c7796e1f0b99e4b5b7. -/

namespace S13K.Chunks.C00838

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00838.txt"

theorem chk : chkChunk S N 71444 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 71444 71540 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00838
