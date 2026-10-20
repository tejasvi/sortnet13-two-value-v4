import S13Kernel.Data.Keys

/-! Keys number 60658 to 60763. `data/c/c00727.txt` has sha256 b93fa2099a26a548fc175a6c6988ef313b5cdd347b19727d1b9d27bc81733bc9. -/

namespace S13K.Chunks.C00727

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00727.txt"

theorem chk : chkChunk S N 60658 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 60658 60764 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00727
