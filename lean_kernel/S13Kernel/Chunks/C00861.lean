import S13Kernel.Data.Keys

/-! Keys number 73586 to 73683. `data/c/c00861.txt` has sha256 c09449622903374db195d88e47a66fd82a9b035ad53a367d205a4e776421f649. -/

namespace S13K.Chunks.C00861

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00861.txt"

theorem chk : chkChunk S N 73586 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 73586 73684 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00861
