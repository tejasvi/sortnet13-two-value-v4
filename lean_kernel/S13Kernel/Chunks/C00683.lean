import S13Kernel.Data.Keys

/-! Keys number 56345 to 56423. `data/c/c00683.txt` has sha256 6d8a4c3db3a502c267baf2e63b04826ce970035dc361ee57f1b3e7269d059970. -/

namespace S13K.Chunks.C00683

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00683.txt"

theorem chk : chkChunk S N 56345 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 56345 56424 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00683
