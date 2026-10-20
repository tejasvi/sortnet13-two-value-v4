import S13Kernel.Data.Keys

/-! Keys number 22545 to 22620. `data/c/c00310.txt` has sha256 8c9d069be5634e1b19c819f15f9c302c8bec629eb2118dd30ab386372c5d987b. -/

namespace S13K.Chunks.C00310

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00310.txt"

theorem chk : chkChunk S N 22545 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 22545 22621 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00310
