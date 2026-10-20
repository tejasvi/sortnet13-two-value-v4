import S13Kernel.Data.Keys

/-! Keys number 22800 to 22877. `data/c/c00313.txt` has sha256 ebb70b4bea183b8e3070e25802d7f978a89838fb04c8500b3fd9742bc5ca1b62. -/

namespace S13K.Chunks.C00313

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00313.txt"

theorem chk : chkChunk S N 22800 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 22800 22878 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00313
