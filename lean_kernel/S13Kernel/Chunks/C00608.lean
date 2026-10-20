import S13Kernel.Data.Keys

/-! Keys number 49453 to 49546. `data/c/c00608.txt` has sha256 0923f225c62a9921077dea5d5cc9126de726e65191e962a39f080ae5afa94158. -/

namespace S13K.Chunks.C00608

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00608.txt"

theorem chk : chkChunk S N 49453 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 49453 49547 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00608
