import S13Kernel.Data.Keys

/-! Keys number 50893 to 50975. `data/c/c00625.txt` has sha256 4c94782f7a6b3dd61305c81df7b73a06fad25bf7194d16f26dbe797412e2c2f5. -/

namespace S13K.Chunks.C00625

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00625.txt"

theorem chk : chkChunk S N 50893 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 50893 50976 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00625
