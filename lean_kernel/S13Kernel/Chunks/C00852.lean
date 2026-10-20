import S13Kernel.Data.Keys

/-! Keys number 72737 to 72835. `data/c/c00852.txt` has sha256 82fdb64e109e1f3a704753d263c7bca81147b2df28aabd6043d8f06ff26a0ee9. -/

namespace S13K.Chunks.C00852

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00852.txt"

theorem chk : chkChunk S N 72737 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 72737 72836 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00852
