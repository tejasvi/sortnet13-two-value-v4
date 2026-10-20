import S13Kernel.Data.Keys

/-! Keys number 1423 to 1478. `data/c/c00029.txt` has sha256 fa9fbd684d2efe254b07c645f0f48c6e908d1eb1902a50dd936a234e862ecbb2. -/

namespace S13K.Chunks.C00029

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00029.txt"

theorem chk : chkChunk S N 1423 56 ces = true := by decide +kernel

theorem ok : RangeOK S N 1423 1479 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00029
