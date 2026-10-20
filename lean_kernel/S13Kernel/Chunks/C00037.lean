import S13Kernel.Data.Keys

/-! Keys number 1891 to 1967. `data/c/c00037.txt` has sha256 fe92857871ea218eed92d7844aef71590fb1aab4c9d0d15e3c2d199bb24acb55. -/

namespace S13K.Chunks.C00037

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00037.txt"

theorem chk : chkChunk S N 1891 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 1891 1968 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00037
