import S13Kernel.Data.Keys

/-! Keys number 82530 to 82634. `data/c/c00948.txt` has sha256 1ad85f5150c12d00f4e744f0bf2395f4e208e6d04fea5626694362f3ce581146. -/

namespace S13K.Chunks.C00948

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00948.txt"

theorem chk : chkChunk S N 82530 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 82530 82635 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00948
