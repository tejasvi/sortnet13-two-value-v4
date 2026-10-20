import S13Kernel.Data.Keys

/-! Keys number 70140 to 70244. `data/c/c00825.txt` has sha256 cf07e87f95051210b2ee4db8f9cc27309e5197d9b23ffcb552658b14af6e9f2c. -/

namespace S13K.Chunks.C00825

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00825.txt"

theorem chk : chkChunk S N 70140 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 70140 70245 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00825
