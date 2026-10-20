import S13Kernel.Data.Keys

/-! Keys number 1830 to 1890. `data/c/c00036.txt` has sha256 048387a0fdc40ce0c8b3d210ddef6d97f7d16d5f2fde09688fae530a9a4aeb5c. -/

namespace S13K.Chunks.C00036

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00036.txt"

theorem chk : chkChunk S N 1830 61 ces = true := by decide +kernel

theorem ok : RangeOK S N 1830 1891 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00036
