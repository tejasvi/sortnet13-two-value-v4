import S13Kernel.Data.Keys

/-! Keys number 53343 to 53435. `data/c/c00651.txt` has sha256 2b68f7484cd10c7c31d6a9ebec6c87395ce6929cdee4079426420043106a66d7. -/

namespace S13K.Chunks.C00651

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00651.txt"

theorem chk : chkChunk S N 53343 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 53343 53436 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00651
