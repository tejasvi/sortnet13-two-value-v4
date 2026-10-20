import S13Kernel.Data.Keys

/-! Keys number 11004 to 11053. `data/c/c00166.txt` has sha256 d2ed028fed7d571e4b8b673ea5c75c018e5080c67ddc7f992ab447966e90a8c8. -/

namespace S13K.Chunks.C00166

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00166.txt"

theorem chk : chkChunk S N 11004 50 ces = true := by decide +kernel

theorem ok : RangeOK S N 11004 11054 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00166
