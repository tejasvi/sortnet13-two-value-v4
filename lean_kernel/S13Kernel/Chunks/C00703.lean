import S13Kernel.Data.Keys

/-! Keys number 58158 to 58244. `data/c/c00703.txt` has sha256 b3a0b73e049ecaf141fb0afd24050d090fd960c62715cf0971333c6141bf1ae3. -/

namespace S13K.Chunks.C00703

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00703.txt"

theorem chk : chkChunk S N 58158 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 58158 58245 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00703
