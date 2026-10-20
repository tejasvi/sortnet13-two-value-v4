import S13Kernel.Data.Keys

/-! Keys number 56081 to 56167. `data/c/c00680.txt` has sha256 7e01b816b5404d8c8044e901b999f046fed589bec00424d0091ea2742f128713. -/

namespace S13K.Chunks.C00680

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00680.txt"

theorem chk : chkChunk S N 56081 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 56081 56168 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00680
