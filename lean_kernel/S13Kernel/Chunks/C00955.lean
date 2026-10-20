import S13Kernel.Data.Keys

/-! Keys number 83263 to 83372. `data/c/c00955.txt` has sha256 fd4606a7545d0af4d2469b20d709a9324ef8b3da94d27088868e180bbd5b7f4d. -/

namespace S13K.Chunks.C00955

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00955.txt"

theorem chk : chkChunk S N 83263 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 83263 83373 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00955
