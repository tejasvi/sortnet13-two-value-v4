import S13Kernel.Data.Keys

/-! Keys number 89955 to 90061. `data/c/c01017.txt` has sha256 47935c45f7fbbb74453f7b833f70a5790b5e2fc7dc602935f6fab028f43b126c. -/

namespace S13K.Chunks.C01017

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01017.txt"

theorem chk : chkChunk S N 89955 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 89955 90062 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01017
