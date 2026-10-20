import S13Kernel.Data.Keys

/-! Keys number 79115 to 79227. `data/c/c00914.txt` has sha256 6e741067d69e33d40eaf7506e2d9c34047c12ed979f2a278addb5d4a0073ba08. -/

namespace S13K.Chunks.C00914

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00914.txt"

theorem chk : chkChunk S N 79115 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 79115 79228 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00914
