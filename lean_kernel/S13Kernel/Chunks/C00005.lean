import S13Kernel.Data.Keys

/-! Keys number 190 to 234. `data/c/c00005.txt` has sha256 c09a6b6aa5e4f6afd76039a4b05c6b185578a76d320d7edb958183de29e6b136. -/

namespace S13K.Chunks.C00005

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00005.txt"

theorem chk : chkChunk S N 190 45 ces = true := by decide +kernel

theorem ok : RangeOK S N 190 235 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00005
