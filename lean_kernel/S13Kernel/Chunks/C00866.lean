import S13Kernel.Data.Keys

/-! Keys number 74054 to 74139. `data/c/c00866.txt` has sha256 84e4e5ac21b90d37fa8acee006371fe357b125b0e5fe701f85c5b8a8a8b8887f. -/

namespace S13K.Chunks.C00866

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00866.txt"

theorem chk : chkChunk S N 74054 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 74054 74140 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00866
