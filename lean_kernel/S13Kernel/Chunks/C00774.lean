import S13Kernel.Data.Keys

/-! Keys number 65278 to 65365. `data/c/c00774.txt` has sha256 bab882d87134c49416ec1a4e15cf72b635b2f92525301b78f9aec4df0bc9ef78. -/

namespace S13K.Chunks.C00774

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00774.txt"

theorem chk : chkChunk S N 65278 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 65278 65366 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00774
