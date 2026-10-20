import S13Kernel.Data.Keys

/-! Keys number 60860 to 60953. `data/c/c00729.txt` has sha256 5d4632017830a2b19d5348a3aaaa651219879cec3c5229b3d0991294963da91f. -/

namespace S13K.Chunks.C00729

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00729.txt"

theorem chk : chkChunk S N 60860 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 60860 60954 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00729
