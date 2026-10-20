import S13Kernel.Data.Keys

/-! Keys number 7322 to 7396. `data/c/c00118.txt` has sha256 e605dbf0b1595ed971778b2a8a9e477fa607912ffcff3dfe14343ea31101b109. -/

namespace S13K.Chunks.C00118

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00118.txt"

theorem chk : chkChunk S N 7322 75 ces = true := by decide +kernel

theorem ok : RangeOK S N 7322 7397 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00118
