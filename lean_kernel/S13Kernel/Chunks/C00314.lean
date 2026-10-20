import S13Kernel.Data.Keys

/-! Keys number 22878 to 22975. `data/c/c00314.txt` has sha256 f20b619ebbfad09df674eeec92bf5e6b234122d2f6abc19d41b4f20d380fe9a1. -/

namespace S13K.Chunks.C00314

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00314.txt"

theorem chk : chkChunk S N 22878 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 22878 22976 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00314
