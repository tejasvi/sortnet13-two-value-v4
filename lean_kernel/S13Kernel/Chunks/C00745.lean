import S13Kernel.Data.Keys

/-! Keys number 62474 to 62567. `data/c/c00745.txt` has sha256 8d0428f2cb8759a472bafb75fb0b10416d5116a02038b8df35229f5c86995551. -/

namespace S13K.Chunks.C00745

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00745.txt"

theorem chk : chkChunk S N 62474 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 62474 62568 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00745
