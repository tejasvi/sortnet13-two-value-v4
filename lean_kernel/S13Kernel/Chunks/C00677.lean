import S13Kernel.Data.Keys

/-! Keys number 55826 to 55906. `data/c/c00677.txt` has sha256 5a23e7179e374b3ad8aa9d796750412b3a3fc198fabe12712ea59365c12d69ad. -/

namespace S13K.Chunks.C00677

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00677.txt"

theorem chk : chkChunk S N 55826 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 55826 55907 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00677
