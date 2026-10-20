import S13Kernel.Data.Keys

/-! Keys number 91369 to 91489. `data/c/c01030.txt` has sha256 d2c9db3689c31883df07e1544d05bbc60c8c77376a93261288a5b2452d1df461. -/

namespace S13K.Chunks.C01030

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01030.txt"

theorem chk : chkChunk S N 91369 121 ces = true := by decide +kernel

theorem ok : RangeOK S N 91369 91490 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01030
