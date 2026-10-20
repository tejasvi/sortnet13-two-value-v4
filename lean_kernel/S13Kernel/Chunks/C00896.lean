import S13Kernel.Data.Keys

/-! Keys number 77233 to 77335. `data/c/c00896.txt` has sha256 1c627fc6e2166dc66df751d7926d9403df082587c432b8cfbbd4fd49e1a66d4c. -/

namespace S13K.Chunks.C00896

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00896.txt"

theorem chk : chkChunk S N 77233 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 77233 77336 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00896
