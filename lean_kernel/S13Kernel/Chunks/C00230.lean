import S13Kernel.Data.Keys

/-! Keys number 16085 to 16173. `data/c/c00230.txt` has sha256 08e9567f7cd6e5cd493d4ea104bc0e098239288e52e133ec943d6c97ec173302. -/

namespace S13K.Chunks.C00230

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00230.txt"

theorem chk : chkChunk S N 16085 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 16085 16174 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00230
