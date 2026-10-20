import S13Kernel.Data.Keys

/-! Keys number 11777 to 11840. `data/c/c00178.txt` has sha256 1d50510ead55c92e63746e5e17b692aeeb69ff4b49f6b3efbefbf38bfd1c4a36. -/

namespace S13K.Chunks.C00178

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00178.txt"

theorem chk : chkChunk S N 11777 64 ces = true := by decide +kernel

theorem ok : RangeOK S N 11777 11841 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00178
