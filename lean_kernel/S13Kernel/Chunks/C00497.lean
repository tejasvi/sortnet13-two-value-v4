import S13Kernel.Data.Keys

/-! Keys number 39200 to 39273. `data/c/c00497.txt` has sha256 13c7590b579c4f219a97be6c4025257eb5e23913ec641e27d42a2d319c22d3c1. -/

namespace S13K.Chunks.C00497

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00497.txt"

theorem chk : chkChunk S N 39200 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 39200 39274 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00497
