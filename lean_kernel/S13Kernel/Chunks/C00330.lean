import S13Kernel.Data.Keys

/-! Keys number 24445 to 24522. `data/c/c00330.txt` has sha256 16fb384085ab36c0ad4e7f2284167a6bdb98ed90ec402cea9350cd4ccf6bf8d8. -/

namespace S13K.Chunks.C00330

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00330.txt"

theorem chk : chkChunk S N 24445 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 24445 24523 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00330
