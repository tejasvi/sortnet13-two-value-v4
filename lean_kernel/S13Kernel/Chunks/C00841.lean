import S13Kernel.Data.Keys

/-! Keys number 71727 to 71822. `data/c/c00841.txt` has sha256 a8d009d52b3bd196c80315e0791e3a54507e7a228718e178a8e090ac86ec1494. -/

namespace S13K.Chunks.C00841

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00841.txt"

theorem chk : chkChunk S N 71727 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 71727 71823 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00841
