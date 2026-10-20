import S13Kernel.Data.Keys

/-! Keys number 33702 to 33777. `data/c/c00435.txt` has sha256 e0e9be8f0db58f1a42f6153e7e7e2f45ba2746d9101e109041e00596bfc401ab. -/

namespace S13K.Chunks.C00435

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00435.txt"

theorem chk : chkChunk S N 33702 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 33702 33778 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00435
