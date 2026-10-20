import S13Kernel.Data.Keys

/-! Keys number 3315 to 3371. `data/c/c00060.txt` has sha256 47dbacf69ff2d2e16c545cbd8ffafc961bce1456864f142e1a0ea52246fba635. -/

namespace S13K.Chunks.C00060

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00060.txt"

theorem chk : chkChunk S N 3315 57 ces = true := by decide +kernel

theorem ok : RangeOK S N 3315 3372 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00060
