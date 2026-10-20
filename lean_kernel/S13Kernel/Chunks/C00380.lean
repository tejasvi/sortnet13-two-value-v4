import S13Kernel.Data.Keys

/-! Keys number 28860 to 28966. `data/c/c00380.txt` has sha256 4e753c2bcc2d7fef5ed032755921aafd2bf384424d3f02d5fcd58884e69deaf9. -/

namespace S13K.Chunks.C00380

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00380.txt"

theorem chk : chkChunk S N 28860 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 28860 28967 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00380
