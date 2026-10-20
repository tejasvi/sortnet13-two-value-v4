import S13Kernel.Data.Keys

/-! Keys number 22162 to 22235. `data/c/c00305.txt` has sha256 aca9b17273554d82baba4015e1771208d99d0c070bf13af39bf26e30f03b63e7. -/

namespace S13K.Chunks.C00305

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00305.txt"

theorem chk : chkChunk S N 22162 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 22162 22236 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00305
