import S13Kernel.Data.Keys

/-! Keys number 15891 to 15986. `data/c/c00228.txt` has sha256 8c5832d2eb663b3a861206c418e1a2d1e5ad563d51bdf6ac8692d45a1b0f39a2. -/

namespace S13K.Chunks.C00228

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00228.txt"

theorem chk : chkChunk S N 15891 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 15891 15987 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00228
