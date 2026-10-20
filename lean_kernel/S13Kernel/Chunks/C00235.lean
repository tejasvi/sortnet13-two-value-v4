import S13Kernel.Data.Keys

/-! Keys number 16468 to 16555. `data/c/c00235.txt` has sha256 36a5689e78df1054860a6ed0af399204157adedc30690abbe011a1dd0f045774. -/

namespace S13K.Chunks.C00235

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00235.txt"

theorem chk : chkChunk S N 16468 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 16468 16556 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00235
