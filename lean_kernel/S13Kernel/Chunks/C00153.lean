import S13Kernel.Data.Keys

/-! Keys number 10061 to 10127. `data/c/c00153.txt` has sha256 9e02c80483ed2a125fed8741aa54b004dd7896b2f53cc04853df75fa3b4758c2. -/

namespace S13K.Chunks.C00153

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00153.txt"

theorem chk : chkChunk S N 10061 67 ces = true := by decide +kernel

theorem ok : RangeOK S N 10061 10128 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00153
