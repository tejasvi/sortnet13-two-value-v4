import S13Kernel.Data.Keys

/-! Keys number 83821 to 83932. `data/c/c00960.txt` has sha256 f7a044e456870aa401105a96520201b8101df3b5407908aaa9c4b12db1d14def. -/

namespace S13K.Chunks.C00960

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00960.txt"

theorem chk : chkChunk S N 83821 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 83821 83933 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00960
