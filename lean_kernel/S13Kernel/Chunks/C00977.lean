import S13Kernel.Data.Keys

/-! Keys number 85636 to 85735. `data/c/c00977.txt` has sha256 243e7ecdbf830b3056597bfe331cf1cca31c5d0a79b001dd173e703fc1d7094f. -/

namespace S13K.Chunks.C00977

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00977.txt"

theorem chk : chkChunk S N 85636 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 85636 85736 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00977
