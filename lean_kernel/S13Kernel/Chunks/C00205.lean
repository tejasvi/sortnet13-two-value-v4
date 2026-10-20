import S13Kernel.Data.Keys

/-! Keys number 14025 to 14121. `data/c/c00205.txt` has sha256 6d036b395ca85ec2f694396aa10b1deedab81b8710237fac15ea5255ae17b5eb. -/

namespace S13K.Chunks.C00205

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00205.txt"

theorem chk : chkChunk S N 14025 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 14025 14122 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00205
