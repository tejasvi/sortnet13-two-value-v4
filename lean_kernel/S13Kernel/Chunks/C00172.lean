import S13Kernel.Data.Keys

/-! Keys number 11353 to 11421. `data/c/c00172.txt` has sha256 c7b0c6071a9f97f4afa2a963c159813b0a25dff186df1d81da1da6ecfe47a7ff. -/

namespace S13K.Chunks.C00172

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00172.txt"

theorem chk : chkChunk S N 11353 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 11353 11422 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00172
