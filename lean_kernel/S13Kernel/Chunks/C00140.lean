import S13Kernel.Data.Keys

/-! Keys number 9001 to 9088. `data/c/c00140.txt` has sha256 71f0cec5fdc03675980b645a7843351063f9ae3aeb1b09beb80de91896d9ccc6. -/

namespace S13K.Chunks.C00140

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00140.txt"

theorem chk : chkChunk S N 9001 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 9001 9089 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00140
