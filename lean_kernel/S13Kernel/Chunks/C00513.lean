import S13Kernel.Data.Keys

/-! Keys number 40585 to 40657. `data/c/c00513.txt` has sha256 4606f7e3374ec47a9201533b83370338d77b8abdeb3f856709e3a256e791c767. -/

namespace S13K.Chunks.C00513

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00513.txt"

theorem chk : chkChunk S N 40585 73 ces = true := by decide +kernel

theorem ok : RangeOK S N 40585 40658 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00513
