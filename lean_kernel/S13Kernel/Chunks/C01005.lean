import S13Kernel.Data.Keys

/-! Keys number 88597 to 88716. `data/c/c01005.txt` has sha256 60959fc74d719532942d902df8aba0361db68e7a3f5a8fb6e0dadc9e60389c22. -/

namespace S13K.Chunks.C01005

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01005.txt"

theorem chk : chkChunk S N 88597 120 ces = true := by decide +kernel

theorem ok : RangeOK S N 88597 88717 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01005
