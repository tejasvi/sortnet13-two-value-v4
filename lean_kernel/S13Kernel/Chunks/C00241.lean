import S13Kernel.Data.Keys

/-! Keys number 17012 to 17098. `data/c/c00241.txt` has sha256 a8c5cc7a204cf8d87a1226786aa1f66ad23372d3c9c1cdb02e289e3e488573a1. -/

namespace S13K.Chunks.C00241

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00241.txt"

theorem chk : chkChunk S N 17012 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 17012 17099 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00241
