import S13Kernel.Data.Keys

/-! Keys number 6893 to 6967. `data/c/c00112.txt` has sha256 49ffabba6dc652527f250bff8027f71821e55c4560faf8c73155359f6923f392. -/

namespace S13K.Chunks.C00112

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00112.txt"

theorem chk : chkChunk S N 6893 75 ces = true := by decide +kernel

theorem ok : RangeOK S N 6893 6968 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00112
