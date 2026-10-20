import S13Kernel.Data.Keys

/-! Keys number 13262 to 13351. `data/c/c00196.txt` has sha256 528fddbf541dda237fb696191fe5d4db21610d63479e5031dc00680385c3ab0d. -/

namespace S13K.Chunks.C00196

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00196.txt"

theorem chk : chkChunk S N 13262 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 13262 13352 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00196
