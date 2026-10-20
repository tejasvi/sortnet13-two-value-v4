import S13Kernel.Data.Keys

/-! Keys number 74365 to 74471. `data/c/c00869.txt` has sha256 8f9e76f9ae6c53f04f972a921aa869c587b3d4bace8dde47cdc91d3cd54a0eaf. -/

namespace S13K.Chunks.C00869

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00869.txt"

theorem chk : chkChunk S N 74365 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 74365 74472 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00869
