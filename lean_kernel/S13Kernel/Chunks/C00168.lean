import S13Kernel.Data.Keys

/-! Keys number 11110 to 11177. `data/c/c00168.txt` has sha256 b518931ad47866926773a8655df808d7f878d7cbdbe3ac67450195a44cb706c4. -/

namespace S13K.Chunks.C00168

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00168.txt"

theorem chk : chkChunk S N 11110 68 ces = true := by decide +kernel

theorem ok : RangeOK S N 11110 11178 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00168
