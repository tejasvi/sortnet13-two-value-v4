import S13Kernel.Data.Keys

/-! Keys number 2880 to 2953. `data/c/c00054.txt` has sha256 870216804dcc8d88a81135f70f8ce5c0cfb5b872db21e81d42f2e0260686d96f. -/

namespace S13K.Chunks.C00054

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00054.txt"

theorem chk : chkChunk S N 2880 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 2880 2954 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00054
