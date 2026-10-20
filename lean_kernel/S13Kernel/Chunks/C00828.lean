import S13Kernel.Data.Keys

/-! Keys number 70446 to 70530. `data/c/c00828.txt` has sha256 a37fe462a77a680da4098f57a55d2d501004b2baaab6cc3ee653d2c0d7c96081. -/

namespace S13K.Chunks.C00828

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00828.txt"

theorem chk : chkChunk S N 70446 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 70446 70531 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00828
