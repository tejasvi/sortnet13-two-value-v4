import S13Kernel.Data.Keys

/-! Keys number 18453 to 18521. `data/c/c00257.txt` has sha256 792960a96d1a6c32d87fef63206384e77b3e93f503bcd7b2263f6606a6493bbe. -/

namespace S13K.Chunks.C00257

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00257.txt"

theorem chk : chkChunk S N 18453 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 18453 18522 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00257
