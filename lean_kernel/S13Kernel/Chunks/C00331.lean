import S13Kernel.Data.Keys

/-! Keys number 24523 to 24608. `data/c/c00331.txt` has sha256 508addf2163969fbfb37a05092c2488d6d65f9d926129deea378296a4d9470a4. -/

namespace S13K.Chunks.C00331

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00331.txt"

theorem chk : chkChunk S N 24523 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 24523 24609 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00331
