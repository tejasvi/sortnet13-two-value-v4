import S13Kernel.Data.Keys

/-! Keys number 42883 to 42986. `data/c/c00538.txt` has sha256 f1e4d152673bd8c1b0cfb02a59c799bd2cab38d76b490de2df1985b7e944cf9f. -/

namespace S13K.Chunks.C00538

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00538.txt"

theorem chk : chkChunk S N 42883 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 42883 42987 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00538
