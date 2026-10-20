import S13Kernel.Data.Keys

/-! Keys number 60954 to 61044. `data/c/c00730.txt` has sha256 887f076f29427c18c29a83ebce07d9bb1f298f08c5da4173781ed3bdc9135707. -/

namespace S13K.Chunks.C00730

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00730.txt"

theorem chk : chkChunk S N 60954 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 60954 61045 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00730
