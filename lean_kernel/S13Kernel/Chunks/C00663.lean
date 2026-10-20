import S13Kernel.Data.Keys

/-! Keys number 54455 to 54571. `data/c/c00663.txt` has sha256 0ffbdfa84eb89d03e02f11fcb3f4422ddc8bad7e5eee9a753868f588e3fb7914. -/

namespace S13K.Chunks.C00663

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00663.txt"

theorem chk : chkChunk S N 54455 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 54455 54572 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00663
