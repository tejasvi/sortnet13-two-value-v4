import S13Kernel.Data.Keys

/-! Keys number 1232 to 1299. `data/c/c00026.txt` has sha256 84c7f2226d33d17979598bebeaf16c053650835869629b1a0295f5720a679ec2. -/

namespace S13K.Chunks.C00026

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00026.txt"

theorem chk : chkChunk S N 1232 68 ces = true := by decide +kernel

theorem ok : RangeOK S N 1232 1300 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00026
