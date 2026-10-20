import S13Kernel.Data.Keys

/-! Keys number 56677 to 56775. `data/c/c00687.txt` has sha256 3f61ada6b111b7bdddf72004121985a2fedd8109829e3fb5099218bed7476837. -/

namespace S13K.Chunks.C00687

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00687.txt"

theorem chk : chkChunk S N 56677 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 56677 56776 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00687
