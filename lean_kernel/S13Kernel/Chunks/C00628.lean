import S13Kernel.Data.Keys

/-! Keys number 51155 to 51253. `data/c/c00628.txt` has sha256 69ecbf37f99ac179a81fc049a83ced58dbeca5b2f8691f8ecf369b642fbd2d24. -/

namespace S13K.Chunks.C00628

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00628.txt"

theorem chk : chkChunk S N 51155 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 51155 51254 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00628
