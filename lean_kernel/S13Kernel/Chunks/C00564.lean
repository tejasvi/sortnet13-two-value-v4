import S13Kernel.Data.Keys

/-! Keys number 45441 to 45538. `data/c/c00564.txt` has sha256 8577090fbdfe3860b1d705d9bae38e9a4f50a1bf4c12923e6dfd74f29204ed83. -/

namespace S13K.Chunks.C00564

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00564.txt"

theorem chk : chkChunk S N 45441 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 45441 45539 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00564
