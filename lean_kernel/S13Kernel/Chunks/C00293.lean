import S13Kernel.Data.Keys

/-! Keys number 21212 to 21283. `data/c/c00293.txt` has sha256 d023268477bdd4fe19721dcdbbeb09f8b8d6aee1e42d15a7d55a1ce0a39f673c. -/

namespace S13K.Chunks.C00293

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00293.txt"

theorem chk : chkChunk S N 21212 72 ces = true := by decide +kernel

theorem ok : RangeOK S N 21212 21284 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00293
