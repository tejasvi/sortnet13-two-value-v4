import S13Kernel.Data.Keys

/-! Keys number 84695 to 84792. `data/c/c00968.txt` has sha256 ab0ab4b17f0523961189a1dc9d19ebb9a3ee7c4eb8c1a690c49db64feb96d2b6. -/

namespace S13K.Chunks.C00968

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00968.txt"

theorem chk : chkChunk S N 84695 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 84695 84793 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00968
