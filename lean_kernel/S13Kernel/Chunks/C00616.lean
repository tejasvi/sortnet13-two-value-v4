import S13Kernel.Data.Keys

/-! Keys number 50114 to 50193. `data/c/c00616.txt` has sha256 0b2e16f2b74897eb1a2b8b1a0bff1ba8d7c75ba38f044141032c60a99c720930. -/

namespace S13K.Chunks.C00616

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00616.txt"

theorem chk : chkChunk S N 50114 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 50114 50194 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00616
