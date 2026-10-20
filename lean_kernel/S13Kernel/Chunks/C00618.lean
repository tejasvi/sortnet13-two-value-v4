import S13Kernel.Data.Keys

/-! Keys number 50277 to 50367. `data/c/c00618.txt` has sha256 8804bc289735762bc50eaf87cf3d3ef0b5124ac8e81ece815b3a47ba5d40478e. -/

namespace S13K.Chunks.C00618

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00618.txt"

theorem chk : chkChunk S N 50277 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 50277 50368 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00618
