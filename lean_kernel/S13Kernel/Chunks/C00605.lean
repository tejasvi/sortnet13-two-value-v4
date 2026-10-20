import S13Kernel.Data.Keys

/-! Keys number 49190 to 49275. `data/c/c00605.txt` has sha256 87434111795b77495e10c5ebeed1963067d3afe5c30cc8516e8b35b4440b2fe1. -/

namespace S13K.Chunks.C00605

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00605.txt"

theorem chk : chkChunk S N 49190 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 49190 49276 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00605
