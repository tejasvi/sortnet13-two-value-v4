import S13Kernel.Data.Keys

/-! Keys number 96693 to 96809. `data/c/c01077.txt` has sha256 5d2d35cdcf5a06094ef49130c97e3ecaeddb9ed46799d26b196608753655db10. -/

namespace S13K.Chunks.C01077

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01077.txt"

theorem chk : chkChunk S N 96693 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 96693 96810 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01077
