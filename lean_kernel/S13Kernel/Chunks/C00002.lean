import S13Kernel.Data.Keys

/-! Keys number 69 to 108. `data/c/c00002.txt` has sha256 654da68f1a94e4072b8c01659c0b01fd5030e0dfa927830b771e172fdd8d9da7. -/

namespace S13K.Chunks.C00002

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00002.txt"

theorem chk : chkChunk S N 69 40 ces = true := by decide +kernel

theorem ok : RangeOK S N 69 109 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00002
