import S13Kernel.Data.Keys

/-! Keys number 38316 to 38424. `data/c/c00487.txt` has sha256 c879188c1f4c5ff147cdbaaa5bdc416501a990a994453bcb19cd4d38b5fa21cb. -/

namespace S13K.Chunks.C00487

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00487.txt"

theorem chk : chkChunk S N 38316 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 38316 38425 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00487
