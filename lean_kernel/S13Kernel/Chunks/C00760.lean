import S13Kernel.Data.Keys

/-! Keys number 63898 to 63992. `data/c/c00760.txt` has sha256 ca2580aa805a94182ace8d3a70d83744ad525e03e8d82a829b23355c1dc9041f. -/

namespace S13K.Chunks.C00760

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00760.txt"

theorem chk : chkChunk S N 63898 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 63898 63993 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00760
