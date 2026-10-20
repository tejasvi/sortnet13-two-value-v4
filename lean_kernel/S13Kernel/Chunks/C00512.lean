import S13Kernel.Data.Keys

/-! Keys number 40509 to 40584. `data/c/c00512.txt` has sha256 7b589db7da5e32be6fae207a10e4a8d09e0560e1da372b8a5a68a9b6888f317e. -/

namespace S13K.Chunks.C00512

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00512.txt"

theorem chk : chkChunk S N 40509 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 40509 40585 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00512
