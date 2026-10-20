import S13Kernel.Data.Keys

/-! Keys number 50368 to 50461. `data/c/c00619.txt` has sha256 4d356889ce64dc85c69503a035feea53d6239551def91055136b5f10a3b4835b. -/

namespace S13K.Chunks.C00619

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00619.txt"

theorem chk : chkChunk S N 50368 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 50368 50462 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00619
