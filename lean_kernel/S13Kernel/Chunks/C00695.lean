import S13Kernel.Data.Keys

/-! Keys number 57406 to 57506. `data/c/c00695.txt` has sha256 776ba873b547a14b7fcbec8f520bd97480530e3bc4de334101d0dc56fc911d3c. -/

namespace S13K.Chunks.C00695

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00695.txt"

theorem chk : chkChunk S N 57406 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 57406 57507 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00695
