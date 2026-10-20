import S13Kernel.Data.Keys

/-! Keys number 58079 to 58157. `data/c/c00702.txt` has sha256 ad190ad060f29c71d8a0390f7c81c39315844d27370ecd3e1c9386aadfd36473. -/

namespace S13K.Chunks.C00702

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00702.txt"

theorem chk : chkChunk S N 58079 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 58079 58158 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00702
