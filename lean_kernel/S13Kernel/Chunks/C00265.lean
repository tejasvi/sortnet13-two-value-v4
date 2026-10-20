import S13Kernel.Data.Keys

/-! Keys number 19122 to 19199. `data/c/c00265.txt` has sha256 1289a4a9dae688a5ba5b468071aeab8c04b710b9d6c3708d2098f2db9fee9fd6. -/

namespace S13K.Chunks.C00265

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00265.txt"

theorem chk : chkChunk S N 19122 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 19122 19200 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00265
