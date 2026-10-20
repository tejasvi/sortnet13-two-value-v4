import S13Kernel.Data.Keys

/-! Keys number 9369 to 9437. `data/c/c00144.txt` has sha256 3ea106549f11de4547cf026be1a518967cd3d6713050abd2e9db415729c36d9d. -/

namespace S13K.Chunks.C00144

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00144.txt"

theorem chk : chkChunk S N 9369 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 9369 9438 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00144
