import S13Kernel.Data.Keys

/-! Keys number 14710 to 14800. `data/c/c00214.txt` has sha256 46160a0d884f586ad259558398038b41b0db2597e39ae0500b893fce9177d163. -/

namespace S13K.Chunks.C00214

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00214.txt"

theorem chk : chkChunk S N 14710 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 14710 14801 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00214
