import S13Kernel.Data.Keys

/-! Keys number 28149 to 28233. `data/c/c00372.txt` has sha256 38b59f5d535faa37bf3c9868bdec06afbb5523b28de6d56162f8345ac82a499d. -/

namespace S13K.Chunks.C00372

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00372.txt"

theorem chk : chkChunk S N 28149 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 28149 28234 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00372
