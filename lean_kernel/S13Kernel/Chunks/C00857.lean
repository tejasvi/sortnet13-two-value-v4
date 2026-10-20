import S13Kernel.Data.Keys

/-! Keys number 73219 to 73302. `data/c/c00857.txt` has sha256 7e859afdbe2e529e0802ecf328008e0fdf2f3910eb5a6bf15519615594203f41. -/

namespace S13K.Chunks.C00857

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00857.txt"

theorem chk : chkChunk S N 73219 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 73219 73303 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00857
