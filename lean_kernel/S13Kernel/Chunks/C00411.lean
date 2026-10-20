import S13Kernel.Data.Keys

/-! Keys number 31727 to 31811. `data/c/c00411.txt` has sha256 aba848fd99597a6dafbfa0d8a88af9ab4d99ac240e75c53e002b3f5a7532ac96. -/

namespace S13K.Chunks.C00411

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00411.txt"

theorem chk : chkChunk S N 31727 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 31727 31812 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00411
