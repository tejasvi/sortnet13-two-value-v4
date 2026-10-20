import S13Kernel.Data.Keys

/-! Keys number 56582 to 56676. `data/c/c00686.txt` has sha256 5d4f6ab0fd2bc9fc99a0369b7064ca49a4bd9e7edb118b58cbc6a3db4ee6665a. -/

namespace S13K.Chunks.C00686

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00686.txt"

theorem chk : chkChunk S N 56582 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 56582 56677 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00686
