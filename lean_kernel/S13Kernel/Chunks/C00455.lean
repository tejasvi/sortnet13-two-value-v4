import S13Kernel.Data.Keys

/-! Keys number 35310 to 35400. `data/c/c00455.txt` has sha256 d0c479f47addd9e95aa40847462150fe85809c896fa4880b7a3c276aee44fe7b. -/

namespace S13K.Chunks.C00455

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00455.txt"

theorem chk : chkChunk S N 35310 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 35310 35401 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00455
