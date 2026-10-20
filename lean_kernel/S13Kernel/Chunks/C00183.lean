import S13Kernel.Data.Keys

/-! Keys number 12129 to 12199. `data/c/c00183.txt` has sha256 c1af38e1c237d9c4c1c0f58946f0f413a6b898c04b47fb48071f7ddd1646c438. -/

namespace S13K.Chunks.C00183

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00183.txt"

theorem chk : chkChunk S N 12129 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 12129 12200 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00183
