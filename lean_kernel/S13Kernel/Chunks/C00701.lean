import S13Kernel.Data.Keys

/-! Keys number 57977 to 58078. `data/c/c00701.txt` has sha256 a661eb47d76ae33a6bd52eee48593b7de62505b39cff79f8ab9fe5cae462d96d. -/

namespace S13K.Chunks.C00701

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00701.txt"

theorem chk : chkChunk S N 57977 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 57977 58079 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00701
