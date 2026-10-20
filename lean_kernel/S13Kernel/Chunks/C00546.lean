import S13Kernel.Data.Keys

/-! Keys number 43725 to 43821. `data/c/c00546.txt` has sha256 b363640ff5516422b6ce82a652669a14f0a7ae661f78dcc1d78f14294316f63a. -/

namespace S13K.Chunks.C00546

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00546.txt"

theorem chk : chkChunk S N 43725 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 43725 43822 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00546
