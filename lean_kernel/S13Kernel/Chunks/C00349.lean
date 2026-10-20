import S13Kernel.Data.Keys

/-! Keys number 26013 to 26106. `data/c/c00349.txt` has sha256 7c780be730dc740ee8be84b0dab485c61099f7d550571a15cf1c7ea9777f0a92. -/

namespace S13K.Chunks.C00349

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00349.txt"

theorem chk : chkChunk S N 26013 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 26013 26107 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00349
