import S13Kernel.Data.Keys

/-! Keys number 30564 to 30673. `data/c/c00398.txt` has sha256 de88afc3a63af3f3486ba6145ad91d42dd7c06f03ac35d36d48d9b4d448ef760. -/

namespace S13K.Chunks.C00398

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00398.txt"

theorem chk : chkChunk S N 30564 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 30564 30674 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00398
