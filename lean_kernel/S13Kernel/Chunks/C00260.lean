import S13Kernel.Data.Keys

/-! Keys number 18674 to 18756. `data/c/c00260.txt` has sha256 7f10f886b8d8ba8272d804520e1612feb0b209caf6a2997e615181c3e94710a2. -/

namespace S13K.Chunks.C00260

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00260.txt"

theorem chk : chkChunk S N 18674 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 18674 18757 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00260
