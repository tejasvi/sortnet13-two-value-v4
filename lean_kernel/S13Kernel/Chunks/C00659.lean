import S13Kernel.Data.Keys

/-! Keys number 54055 to 54149. `data/c/c00659.txt` has sha256 ada668bbc62f2a4d6d56b6a972ac20d2336e50c1e6651ebdd2b07b9c24e7abf2. -/

namespace S13K.Chunks.C00659

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00659.txt"

theorem chk : chkChunk S N 54055 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 54055 54150 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00659
