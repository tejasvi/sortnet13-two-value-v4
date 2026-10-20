import S13Kernel.Data.Keys

/-! Keys number 29277 to 29389. `data/c/c00384.txt` has sha256 0d4e1f252fcfb0bdb77d1934335d3332a061bab14cc641a670c019f6ee7d6948. -/

namespace S13K.Chunks.C00384

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00384.txt"

theorem chk : chkChunk S N 29277 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 29277 29390 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00384
