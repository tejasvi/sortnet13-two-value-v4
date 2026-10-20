import S13Kernel.Data.Keys

/-! Keys number 41541 to 41642. `data/c/c00524.txt` has sha256 138167ab12eaed37f3b11966d66596b7e78c117e3a08dc7d9f006cfdad5c7e88. -/

namespace S13K.Chunks.C00524

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00524.txt"

theorem chk : chkChunk S N 41541 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 41541 41643 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00524
