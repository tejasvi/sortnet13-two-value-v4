import S13Kernel.Data.Keys

/-! Keys number 23067 to 23169. `data/c/c00316.txt` has sha256 bff283f978e9de3e0109a2789635887c16c6c31d374b3dfc96bd6f5580836483. -/

namespace S13K.Chunks.C00316

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00316.txt"

theorem chk : chkChunk S N 23067 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 23067 23170 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00316
