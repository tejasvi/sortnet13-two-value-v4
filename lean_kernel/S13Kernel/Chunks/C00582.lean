import S13Kernel.Data.Keys

/-! Keys number 47146 to 47236. `data/c/c00582.txt` has sha256 c4cfab54bbfb0e68f6ed6f85f26f8dced402a0c6536201cee73bbb689f345962. -/

namespace S13K.Chunks.C00582

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00582.txt"

theorem chk : chkChunk S N 47146 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 47146 47237 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00582
