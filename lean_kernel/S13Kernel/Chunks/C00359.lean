import S13Kernel.Data.Keys

/-! Keys number 26891 to 26966. `data/c/c00359.txt` has sha256 6234c61400f79e5bda72f61db81fe0d6da66afeadf602073bff763a8145b3e03. -/

namespace S13K.Chunks.C00359

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00359.txt"

theorem chk : chkChunk S N 26891 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 26891 26967 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00359
