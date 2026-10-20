import S13Kernel.Data.Keys

/-! Keys number 31978 to 32067. `data/c/c00414.txt` has sha256 065756eddfb56ae7e942d11790ca7f1cc80c96d733d072fa4d54524dfd45fb76. -/

namespace S13K.Chunks.C00414

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00414.txt"

theorem chk : chkChunk S N 31978 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 31978 32068 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00414
