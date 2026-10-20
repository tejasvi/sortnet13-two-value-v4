import S13Kernel.Data.Keys

/-! Keys number 5743 to 5806. `data/c/c00097.txt` has sha256 b273d5d57cc0328e04fa6ca7c3b747f598e3cfb9004be9683905bf25a2feb744. -/

namespace S13K.Chunks.C00097

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00097.txt"

theorem chk : chkChunk S N 5743 64 ces = true := by decide +kernel

theorem ok : RangeOK S N 5743 5807 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00097
