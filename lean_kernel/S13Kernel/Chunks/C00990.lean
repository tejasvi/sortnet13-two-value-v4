import S13Kernel.Data.Keys

/-! Keys number 86953 to 87050. `data/c/c00990.txt` has sha256 b92bc8cc606155fbb3d6d7a224b152803790512f6fdb34d19fe639d6c271bbb9. -/

namespace S13K.Chunks.C00990

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00990.txt"

theorem chk : chkChunk S N 86953 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 86953 87051 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00990
