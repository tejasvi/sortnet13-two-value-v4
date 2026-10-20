import S13Kernel.Data.Keys

/-! Keys number 38197 to 38315. `data/c/c00486.txt` has sha256 eccb0372e67654802e8cc301cfb30b106d884efef0599e1fd3ea3f476d3f4a99. -/

namespace S13K.Chunks.C00486

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00486.txt"

theorem chk : chkChunk S N 38197 119 ces = true := by decide +kernel

theorem ok : RangeOK S N 38197 38316 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00486
