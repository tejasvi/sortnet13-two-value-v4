import S13Kernel.Data.Keys

/-! Keys number 94604 to 94708. `data/c/c01059.txt` has sha256 47a16b3f4be6ce81775cf86ef89e478df1a24efe8678600481fbfa22733ef843. -/

namespace S13K.Chunks.C01059

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01059.txt"

theorem chk : chkChunk S N 94604 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 94604 94709 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01059
