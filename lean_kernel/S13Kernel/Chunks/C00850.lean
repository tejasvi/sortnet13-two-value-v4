import S13Kernel.Data.Keys

/-! Keys number 72560 to 72650. `data/c/c00850.txt` has sha256 6ac52080a159fabb7c772a7c5db2916a3bcdabcd1ed5b8b33de67203ebcab736. -/

namespace S13K.Chunks.C00850

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00850.txt"

theorem chk : chkChunk S N 72560 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 72560 72651 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00850
