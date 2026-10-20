import S13Kernel.Data.Keys

/-! Keys number 21150 to 21211. `data/c/c00292.txt` has sha256 40d3159111cae2074fce23b50080184fe227cc810c1b7e0fd547e1adb9eb17a2. -/

namespace S13K.Chunks.C00292

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00292.txt"

theorem chk : chkChunk S N 21150 62 ces = true := by decide +kernel

theorem ok : RangeOK S N 21150 21212 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00292
