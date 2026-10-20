import S13Kernel.Data.Keys

/-! Keys number 27952 to 28051. `data/c/c00370.txt` has sha256 69b79c5e62d039698e2aa2044ecd035d25eaceb8163e113a18f2d6a3fed8b4fa. -/

namespace S13K.Chunks.C00370

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00370.txt"

theorem chk : chkChunk S N 27952 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 27952 28052 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00370
