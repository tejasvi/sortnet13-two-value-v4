import S13Kernel.Data.Keys

/-! Keys number 19455 to 19539. `data/c/c00269.txt` has sha256 92a1a6a046c97e5687bc5fe2952746d619a71a82216de80985063a003192ab45. -/

namespace S13K.Chunks.C00269

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00269.txt"

theorem chk : chkChunk S N 19455 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 19455 19540 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00269
