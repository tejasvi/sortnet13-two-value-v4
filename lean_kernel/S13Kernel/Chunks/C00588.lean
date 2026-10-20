import S13Kernel.Data.Keys

/-! Keys number 47677 to 47768. `data/c/c00588.txt` has sha256 0a5e35c992b0ae3824545e99260309aecd3d2180647bb1408bbdc1d339875c01. -/

namespace S13K.Chunks.C00588

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00588.txt"

theorem chk : chkChunk S N 47677 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 47677 47769 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00588
