import S13Kernel.Data.Keys

/-! Keys number 24856 to 24931. `data/c/c00335.txt` has sha256 2eef32e9689ec2aac6d726bc8fa6908da4720d6be43d68a0b09fc2fbd3a8882b. -/

namespace S13K.Chunks.C00335

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00335.txt"

theorem chk : chkChunk S N 24856 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 24856 24932 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00335
