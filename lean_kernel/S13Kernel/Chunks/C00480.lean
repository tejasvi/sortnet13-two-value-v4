import S13Kernel.Data.Keys

/-! Keys number 37525 to 37627. `data/c/c00480.txt` has sha256 abacf7c45bb783ac32ede0bff0b4039c3ae62961c1e3a26f0a74a7d07fee7f46. -/

namespace S13K.Chunks.C00480

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00480.txt"

theorem chk : chkChunk S N 37525 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 37525 37628 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00480
