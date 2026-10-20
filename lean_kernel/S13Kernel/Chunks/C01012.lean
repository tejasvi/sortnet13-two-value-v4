import S13Kernel.Data.Keys

/-! Keys number 89370 to 89484. `data/c/c01012.txt` has sha256 919a962c6722a0261b2ecb85c69a34201a73421dfb02592c9068f3a3c7dba977. -/

namespace S13K.Chunks.C01012

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01012.txt"

theorem chk : chkChunk S N 89370 115 ces = true := by decide +kernel

theorem ok : RangeOK S N 89370 89485 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01012
