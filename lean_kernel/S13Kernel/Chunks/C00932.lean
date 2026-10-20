import S13Kernel.Data.Keys

/-! Keys number 80951 to 81044. `data/c/c00932.txt` has sha256 211af0cb18fc8857d5c87080f03308673aab946cd8bdafac83dbc30e8b2f53ae. -/

namespace S13K.Chunks.C00932

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00932.txt"

theorem chk : chkChunk S N 80951 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 80951 81045 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00932
