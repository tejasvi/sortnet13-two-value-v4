import S13Kernel.Data.Keys

/-! Keys number 10128 to 10212. `data/c/c00154.txt` has sha256 8caaeb18a74eca77a630d779078496c8e2064470315521b0f0da1f9686e506ab. -/

namespace S13K.Chunks.C00154

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00154.txt"

theorem chk : chkChunk S N 10128 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 10128 10213 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00154
