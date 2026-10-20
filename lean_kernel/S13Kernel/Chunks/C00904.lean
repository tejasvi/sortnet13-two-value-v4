import S13Kernel.Data.Keys

/-! Keys number 78112 to 78211. `data/c/c00904.txt` has sha256 fca8bea1627ce27456ea9d6ff27f3de22d1b5a77cf5b4a69d20a0b6bd52a1e5e. -/

namespace S13K.Chunks.C00904

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00904.txt"

theorem chk : chkChunk S N 78112 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 78112 78212 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00904
