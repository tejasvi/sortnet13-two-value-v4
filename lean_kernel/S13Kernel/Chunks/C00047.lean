import S13Kernel.Data.Keys

/-! Keys number 2473 to 2514. `data/c/c00047.txt` has sha256 56462111960bd5e7565e20cbeddc2999f790b6d350d5e056c37f51193ac523c2. -/

namespace S13K.Chunks.C00047

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00047.txt"

theorem chk : chkChunk S N 2473 42 ces = true := by decide +kernel

theorem ok : RangeOK S N 2473 2515 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00047
