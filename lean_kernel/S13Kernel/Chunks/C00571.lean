import S13Kernel.Data.Keys

/-! Keys number 46138 to 46219. `data/c/c00571.txt` has sha256 bbe0b0f3b6629fc007d20e180f5ceff771775e3144b0fdb2386e047042186119. -/

namespace S13K.Chunks.C00571

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00571.txt"

theorem chk : chkChunk S N 46138 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 46138 46220 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00571
