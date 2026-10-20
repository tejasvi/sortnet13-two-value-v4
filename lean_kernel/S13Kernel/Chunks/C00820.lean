import S13Kernel.Data.Keys

/-! Keys number 69624 to 69734. `data/c/c00820.txt` has sha256 9703af322c706aef58b4d87877c2c55a5d1741e3d5f32cbb2a8f3af72ad724f3. -/

namespace S13K.Chunks.C00820

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00820.txt"

theorem chk : chkChunk S N 69624 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 69624 69735 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00820
