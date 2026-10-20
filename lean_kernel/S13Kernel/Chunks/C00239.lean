import S13Kernel.Data.Keys

/-! Keys number 16839 to 16935. `data/c/c00239.txt` has sha256 264d9b32886a36e7d98ab5d0371a9107f2c9baa7302f1eb60718d4254ace90b9. -/

namespace S13K.Chunks.C00239

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00239.txt"

theorem chk : chkChunk S N 16839 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 16839 16936 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00239
