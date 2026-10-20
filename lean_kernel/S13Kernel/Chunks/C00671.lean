import S13Kernel.Data.Keys

/-! Keys number 55295 to 55376. `data/c/c00671.txt` has sha256 6c1ed49cf2f36759ad2abf4bf68bad7a7d79efedcc5ddfce442432519455408a. -/

namespace S13K.Chunks.C00671

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00671.txt"

theorem chk : chkChunk S N 55295 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 55295 55377 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00671
