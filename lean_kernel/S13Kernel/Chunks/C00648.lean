import S13Kernel.Data.Keys

/-! Keys number 53053 to 53152. `data/c/c00648.txt` has sha256 de5be95fc2132f249d118f43e451adf9dd3291220d0262b16397f52c8bd273eb. -/

namespace S13K.Chunks.C00648

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00648.txt"

theorem chk : chkChunk S N 53053 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 53053 53153 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00648
