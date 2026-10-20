import S13Kernel.Data.Keys

/-! Keys number 77551 to 77664. `data/c/c00899.txt` has sha256 ac5291e525c858fbdc3ae54cb8d5a95722b2751fe20735c38adfc2f447489a83. -/

namespace S13K.Chunks.C00899

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00899.txt"

theorem chk : chkChunk S N 77551 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 77551 77665 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00899
