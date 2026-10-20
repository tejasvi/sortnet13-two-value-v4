import S13Kernel.Data.Keys

/-! Keys number 71823 to 71922. `data/c/c00842.txt` has sha256 11b714ed8253146f6e0a3d4a52cdd1767abf4acf2c710328fdea1ab941664ed3. -/

namespace S13K.Chunks.C00842

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00842.txt"

theorem chk : chkChunk S N 71823 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 71823 71923 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00842
