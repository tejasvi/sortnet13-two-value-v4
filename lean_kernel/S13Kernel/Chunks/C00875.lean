import S13Kernel.Data.Keys

/-! Keys number 74985 to 75096. `data/c/c00875.txt` has sha256 f83f1ee450648072a20938c3dadfa5908c54b16a1a9650903b6c00bc7e654051. -/

namespace S13K.Chunks.C00875

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00875.txt"

theorem chk : chkChunk S N 74985 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 74985 75097 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00875
