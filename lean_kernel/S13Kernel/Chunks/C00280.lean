import S13Kernel.Data.Keys

/-! Keys number 20284 to 20352. `data/c/c00280.txt` has sha256 a7eb951a9f87b51efa28d9cd52d856c3efa3f6220a54c075ef0357b3bc28b96d. -/

namespace S13K.Chunks.C00280

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00280.txt"

theorem chk : chkChunk S N 20284 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 20284 20353 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00280
