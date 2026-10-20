import S13Kernel.Data.Keys

/-! Keys number 68785 to 68887. `data/c/c00812.txt` has sha256 1fff0bb7c11eb0e7c8e462cebbf99d5f0b9625a297d4d10ebc316e4f3037f55a. -/

namespace S13K.Chunks.C00812

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00812.txt"

theorem chk : chkChunk S N 68785 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 68785 68888 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00812
