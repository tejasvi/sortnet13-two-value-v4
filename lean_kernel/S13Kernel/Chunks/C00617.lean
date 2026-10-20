import S13Kernel.Data.Keys

/-! Keys number 50194 to 50276. `data/c/c00617.txt` has sha256 4aea325e2bd03dfc556ebaa80781f7ea22a2f22ecaddabae29e00fbc179c623e. -/

namespace S13K.Chunks.C00617

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00617.txt"

theorem chk : chkChunk S N 50194 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 50194 50277 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00617
