import S13Kernel.Data.Keys

/-! Keys number 57305 to 57405. `data/c/c00694.txt` has sha256 974311ab66fb4f10d3a046d85f1a357a21742bd571368621b7f91d76c208e85d. -/

namespace S13K.Chunks.C00694

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00694.txt"

theorem chk : chkChunk S N 57305 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 57305 57406 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00694
