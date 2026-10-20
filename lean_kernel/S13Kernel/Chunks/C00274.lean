import S13Kernel.Data.Keys

/-! Keys number 19873 to 19935. `data/c/c00274.txt` has sha256 45e5f8fe29d10cf8c31ff852344aef16452cb7588f6784d55fae552aa2e9e951. -/

namespace S13K.Chunks.C00274

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00274.txt"

theorem chk : chkChunk S N 19873 63 ces = true := by decide +kernel

theorem ok : RangeOK S N 19873 19936 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00274
