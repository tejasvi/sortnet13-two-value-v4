import S13Kernel.Data.Keys

/-! Keys number 5304 to 5357. `data/c/c00089.txt` has sha256 36f2f2a1a609353092735ddf7b42988444170495008278ef544bc10a7af9b7dd. -/

namespace S13K.Chunks.C00089

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00089.txt"

theorem chk : chkChunk S N 5304 54 ces = true := by decide +kernel

theorem ok : RangeOK S N 5304 5358 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00089
