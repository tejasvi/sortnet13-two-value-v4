import S13Kernel.Data.Keys

/-! Keys number 73684 to 73774. `data/c/c00862.txt` has sha256 1be832417dc692729c4fa29d32bdddddd19eb7c6b02a548a64774e13f1792c36. -/

namespace S13K.Chunks.C00862

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00862.txt"

theorem chk : chkChunk S N 73684 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 73684 73775 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00862
