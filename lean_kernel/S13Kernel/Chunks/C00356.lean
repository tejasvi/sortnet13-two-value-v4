import S13Kernel.Data.Keys

/-! Keys number 26664 to 26749. `data/c/c00356.txt` has sha256 f530a63ac5dd7a600061f3f6962ce855182f8c23bb6658efda0f03d5fb1c36fa. -/

namespace S13K.Chunks.C00356

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00356.txt"

theorem chk : chkChunk S N 26664 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 26664 26750 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00356
