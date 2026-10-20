import S13Kernel.Data.Keys

/-! Keys number 1588 to 1660. `data/c/c00032.txt` has sha256 8b3a1b9de5568a7a2f7f0780fecdafe65edbe0aa7199c65f326019275fff2851. -/

namespace S13K.Chunks.C00032

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00032.txt"

theorem chk : chkChunk S N 1588 73 ces = true := by decide +kernel

theorem ok : RangeOK S N 1588 1661 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00032
