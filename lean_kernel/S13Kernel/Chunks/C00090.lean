import S13Kernel.Data.Keys

/-! Keys number 5358 to 5414. `data/c/c00090.txt` has sha256 d68076cd8dbc30978a882d46e347bc50398bb8db69c0e7f6968b941dc34d61ad. -/

namespace S13K.Chunks.C00090

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00090.txt"

theorem chk : chkChunk S N 5358 57 ces = true := by decide +kernel

theorem ok : RangeOK S N 5358 5415 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00090
