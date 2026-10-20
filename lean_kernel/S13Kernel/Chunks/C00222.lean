import S13Kernel.Data.Keys

/-! Keys number 15343 to 15437. `data/c/c00222.txt` has sha256 b13c29eb4e1eacd364a12553356dd34667018af2780960d3277d3473d0efa9b8. -/

namespace S13K.Chunks.C00222

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00222.txt"

theorem chk : chkChunk S N 15343 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 15343 15438 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00222
