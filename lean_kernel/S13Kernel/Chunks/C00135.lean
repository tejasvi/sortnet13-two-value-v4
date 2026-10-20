import S13Kernel.Data.Keys

/-! Keys number 8603 to 8690. `data/c/c00135.txt` has sha256 3613c1ad00526e822700fee12c8a4c7cc003dbb3121694a440c28a2e0a9b92be. -/

namespace S13K.Chunks.C00135

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00135.txt"

theorem chk : chkChunk S N 8603 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 8603 8691 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00135
