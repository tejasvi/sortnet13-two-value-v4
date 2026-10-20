import S13Kernel.Data.Keys

/-! Keys number 92556 to 92668. `data/c/c01041.txt` has sha256 6a36258737a09a62acc02e9a4f5118076bab799706ff4dba9a630ac36df8e989. -/

namespace S13K.Chunks.C01041

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01041.txt"

theorem chk : chkChunk S N 92556 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 92556 92669 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01041
