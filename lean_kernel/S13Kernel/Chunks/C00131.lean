import S13Kernel.Data.Keys

/-! Keys number 8325 to 8382. `data/c/c00131.txt` has sha256 6a653e290e7f757d933bdf5496d434ad6e1d257d70138bad6260555882b5b5e0. -/

namespace S13K.Chunks.C00131

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00131.txt"

theorem chk : chkChunk S N 8325 58 ces = true := by decide +kernel

theorem ok : RangeOK S N 8325 8383 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00131
