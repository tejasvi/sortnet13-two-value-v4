import S13Kernel.Data.Keys

/-! Keys number 10688 to 10748. `data/c/c00161.txt` has sha256 51853262eb199d249985ee6e848c00c09a37dd78cf8cc8545d1122c09b2f3379. -/

namespace S13K.Chunks.C00161

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00161.txt"

theorem chk : chkChunk S N 10688 61 ces = true := by decide +kernel

theorem ok : RangeOK S N 10688 10749 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00161
