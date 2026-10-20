import S13Kernel.Data.Keys

/-! Keys number 37964 to 38079. `data/c/c00484.txt` has sha256 38bf6521561e95b525b038b24e03c72c0e3af80bb38ef7bfd225db1f15102a57. -/

namespace S13K.Chunks.C00484

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00484.txt"

theorem chk : chkChunk S N 37964 116 ces = true := by decide +kernel

theorem ok : RangeOK S N 37964 38080 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00484
