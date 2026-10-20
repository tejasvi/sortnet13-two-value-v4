import S13Kernel.Data.Keys

/-! Keys number 49114 to 49189. `data/c/c00604.txt` has sha256 2bd3ded91eeb8b4b778b8a4a637151123c105db7b7dc1e9e2e61a607cd2425df. -/

namespace S13K.Chunks.C00604

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00604.txt"

theorem chk : chkChunk S N 49114 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 49114 49190 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00604
