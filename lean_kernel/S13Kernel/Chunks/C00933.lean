import S13Kernel.Data.Keys

/-! Keys number 81045 to 81140. `data/c/c00933.txt` has sha256 80f1a236ca2fc06e9d2fc2b743f91e43e0dc35ead8215e5a1fbaba1255602674. -/

namespace S13K.Chunks.C00933

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00933.txt"

theorem chk : chkChunk S N 81045 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 81045 81141 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00933
