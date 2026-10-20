import S13Kernel.Data.Keys

/-! Keys number 3372 to 3446. `data/c/c00061.txt` has sha256 4889d67e34fdbdbc7497df5f1f2bc29d0cd4e48d0b452265ef16412587a25a76. -/

namespace S13K.Chunks.C00061

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00061.txt"

theorem chk : chkChunk S N 3372 75 ces = true := by decide +kernel

theorem ok : RangeOK S N 3372 3447 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00061
