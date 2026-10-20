import S13Kernel.Data.Keys

/-! Keys number 74571 to 74668. `data/c/c00871.txt` has sha256 ca1f5322b0e59f48945f5af2551b73b52aa47e202b11945923c62051740a0c02. -/

namespace S13K.Chunks.C00871

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00871.txt"

theorem chk : chkChunk S N 74571 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 74571 74669 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00871
