import S13Kernel.Data.Keys

/-! Keys number 32795 to 32867. `data/c/c00423.txt` has sha256 0e32b0c7802e2aafb3937ec52ce52770bb41a7d1a03d0048b37385231f5847d2. -/

namespace S13K.Chunks.C00423

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00423.txt"

theorem chk : chkChunk S N 32795 73 ces = true := by decide +kernel

theorem ok : RangeOK S N 32795 32868 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00423
