import S13Kernel.Data.Keys

/-! Keys number 45856 to 45962. `data/c/c00568.txt` has sha256 bd13eb7d45d4a6594b3df930b9ba59f10eaf4a0fecfa239d62497757a95d9f3f. -/

namespace S13K.Chunks.C00568

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00568.txt"

theorem chk : chkChunk S N 45856 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 45856 45963 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00568
