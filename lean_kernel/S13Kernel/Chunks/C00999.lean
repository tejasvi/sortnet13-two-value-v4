import S13Kernel.Data.Keys

/-! Keys number 87899 to 88005. `data/c/c00999.txt` has sha256 d3759af75c98208de0a7eec816957798272e24686188d044cf99562656cef05f. -/

namespace S13K.Chunks.C00999

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00999.txt"

theorem chk : chkChunk S N 87899 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 87899 88006 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00999
