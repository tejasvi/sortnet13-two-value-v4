import S13Kernel.Data.Keys

/-! Keys number 44246 to 44339. `data/c/c00551.txt` has sha256 d27c7d54599de96d1423ecadaf857405cc3dd10d1fd46d880fb9162726c5535d. -/

namespace S13K.Chunks.C00551

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00551.txt"

theorem chk : chkChunk S N 44246 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 44246 44340 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00551
