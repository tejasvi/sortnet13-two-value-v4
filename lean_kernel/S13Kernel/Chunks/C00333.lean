import S13Kernel.Data.Keys

/-! Keys number 24679 to 24768. `data/c/c00333.txt` has sha256 037217acff2e28c3da90f04dfe0e5c8fc5b1f6dfee20b9b14e98ea466a122517. -/

namespace S13K.Chunks.C00333

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00333.txt"

theorem chk : chkChunk S N 24679 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 24679 24769 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00333
