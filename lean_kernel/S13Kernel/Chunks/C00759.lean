import S13Kernel.Data.Keys

/-! Keys number 63813 to 63897. `data/c/c00759.txt` has sha256 1fd5690433485a289753e2d4ede791b2942e889b2c70312eeec04a1e9ccb33c8. -/

namespace S13K.Chunks.C00759

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00759.txt"

theorem chk : chkChunk S N 63813 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 63813 63898 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00759
