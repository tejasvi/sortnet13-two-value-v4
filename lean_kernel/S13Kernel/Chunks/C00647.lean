import S13Kernel.Data.Keys

/-! Keys number 52952 to 53052. `data/c/c00647.txt` has sha256 019e554a3cb2883ca9e83e47f450226b18f575c9a82d8b2223e8b512c9a7bd23. -/

namespace S13K.Chunks.C00647

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00647.txt"

theorem chk : chkChunk S N 52952 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 52952 53053 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00647
