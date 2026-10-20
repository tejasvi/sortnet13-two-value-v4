import S13Kernel.Data.Keys

/-! Keys number 76104 to 76210. `data/c/c00885.txt` has sha256 9f949b55c6386b4a4efb0af4a48d4e148bdd880e3e17bbe2766ef96113349d3c. -/

namespace S13K.Chunks.C00885

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00885.txt"

theorem chk : chkChunk S N 76104 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 76104 76211 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00885
