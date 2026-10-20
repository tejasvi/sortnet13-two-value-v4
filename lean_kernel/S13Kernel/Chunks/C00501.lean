import S13Kernel.Data.Keys

/-! Keys number 39535 to 39613. `data/c/c00501.txt` has sha256 243faa5d351f5b067e52c065d3acd7367cb0f2fc27a4d7ea3f927c2aa01f234d. -/

namespace S13K.Chunks.C00501

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00501.txt"

theorem chk : chkChunk S N 39535 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 39535 39614 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00501
