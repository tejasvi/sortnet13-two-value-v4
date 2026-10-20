import S13Kernel.Data.Keys

/-! Keys number 24769 to 24855. `data/c/c00334.txt` has sha256 d2d27ee90c8f0244b34a89fb026bdde8544acba9697f8000ccde5cb5367951dd. -/

namespace S13K.Chunks.C00334

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00334.txt"

theorem chk : chkChunk S N 24769 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 24769 24856 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00334
