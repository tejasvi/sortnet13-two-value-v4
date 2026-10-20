import S13Kernel.Data.Keys

/-! Keys number 90377 to 90484. `data/c/c01021.txt` has sha256 efb41626a5ead678932e102663e969cbee5af3d42191bb03ddda69188ecb6c38. -/

namespace S13K.Chunks.C01021

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01021.txt"

theorem chk : chkChunk S N 90377 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 90377 90485 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01021
