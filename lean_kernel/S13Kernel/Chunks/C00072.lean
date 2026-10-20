import S13Kernel.Data.Keys

/-! Keys number 4120 to 4178. `data/c/c00072.txt` has sha256 12def09d88a58e4c48482f4fd838a31feacd7042897ff12187e55eab887440b9. -/

namespace S13K.Chunks.C00072

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00072.txt"

theorem chk : chkChunk S N 4120 59 ces = true := by decide +kernel

theorem ok : RangeOK S N 4120 4179 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00072
