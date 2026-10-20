import S13Kernel.Data.Keys

/-! Keys number 33778 to 33855. `data/c/c00436.txt` has sha256 960a6e0e1dbc4d5b6ed972612aac8324fece957872be07300c065d3e964dab3d. -/

namespace S13K.Chunks.C00436

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00436.txt"

theorem chk : chkChunk S N 33778 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 33778 33856 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00436
