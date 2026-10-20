import S13Kernel.Data.Keys

/-! Keys number 41925 to 42020. `data/c/c00528.txt` has sha256 99128ca0eb8b7794f3897ad08cf3ee57895d29e98bfc4e29c826daae1282a5a7. -/

namespace S13K.Chunks.C00528

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00528.txt"

theorem chk : chkChunk S N 41925 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 41925 42021 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00528
