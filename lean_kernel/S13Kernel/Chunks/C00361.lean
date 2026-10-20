import S13Kernel.Data.Keys

/-! Keys number 27062 to 27165. `data/c/c00361.txt` has sha256 612dffaa9419a1961f321bee70fa4bb5f833533da5ad2239530cf46ba60ce9d0. -/

namespace S13K.Chunks.C00361

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00361.txt"

theorem chk : chkChunk S N 27062 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 27062 27166 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00361
