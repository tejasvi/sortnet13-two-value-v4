import S13Kernel.Data.Keys

/-! Keys number 8923 to 9000. `data/c/c00139.txt` has sha256 631c20b8172ce1e015f48c84c37428fe36d545cff56d5f8bb4771b50b43d57fd. -/

namespace S13K.Chunks.C00139

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00139.txt"

theorem chk : chkChunk S N 8923 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 8923 9001 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00139
