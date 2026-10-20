import S13Kernel.Data.Keys

/-! Keys number 67891 to 67986. `data/c/c00803.txt` has sha256 a6a41bf6f45185e5f89059fec2730ae5db9230bb3e23d4f3c195f13aa8e89273. -/

namespace S13K.Chunks.C00803

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00803.txt"

theorem chk : chkChunk S N 67891 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 67891 67987 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00803
