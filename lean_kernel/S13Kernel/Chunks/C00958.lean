import S13Kernel.Data.Keys

/-! Keys number 83594 to 83701. `data/c/c00958.txt` has sha256 ffa7d48cb1343d2293d00f258c58d042cd81bf0580cedc647ce232127b589928. -/

namespace S13K.Chunks.C00958

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00958.txt"

theorem chk : chkChunk S N 83594 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 83594 83702 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00958
