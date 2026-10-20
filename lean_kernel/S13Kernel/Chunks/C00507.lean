import S13Kernel.Data.Keys

/-! Keys number 40060 to 40139. `data/c/c00507.txt` has sha256 b21a3bc062c3064a9fb87c2cf83d88dcd32566d73e04ec224c6bf92997f8a1cf. -/

namespace S13K.Chunks.C00507

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00507.txt"

theorem chk : chkChunk S N 40060 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 40060 40140 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00507
