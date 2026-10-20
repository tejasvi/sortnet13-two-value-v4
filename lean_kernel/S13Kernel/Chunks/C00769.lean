import S13Kernel.Data.Keys

/-! Keys number 64779 to 64889. `data/c/c00769.txt` has sha256 edb5d04451a911799b7912c290075c2d63c1edfa006f43c1e219c7b1c2a9c87e. -/

namespace S13K.Chunks.C00769

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00769.txt"

theorem chk : chkChunk S N 64779 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 64779 64890 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00769
