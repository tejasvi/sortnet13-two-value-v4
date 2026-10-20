import S13Kernel.Data.Keys

/-! Keys number 7193 to 7242. `data/c/c00116.txt` has sha256 738d8dd8f5f2164d1caeb5588d858d74edf90b4c8b68286fb8fb2a4281ffd239. -/

namespace S13K.Chunks.C00116

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00116.txt"

theorem chk : chkChunk S N 7193 50 ces = true := by decide +kernel

theorem ok : RangeOK S N 7193 7243 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00116
