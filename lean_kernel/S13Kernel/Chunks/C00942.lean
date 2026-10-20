import S13Kernel.Data.Keys

/-! Keys number 81924 to 82028. `data/c/c00942.txt` has sha256 80c34ba5fddfc92c9e251b990e5a90ae9bfbaf857c4df7eb085cec31b7dbdb1e. -/

namespace S13K.Chunks.C00942

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00942.txt"

theorem chk : chkChunk S N 81924 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 81924 82029 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00942
