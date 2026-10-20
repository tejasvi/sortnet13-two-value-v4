import S13Kernel.Data.Keys

/-! Keys number 35655 to 35736. `data/c/c00459.txt` has sha256 9b97808d5d1cf5a2ffcef81d2426b385d2efb92fa2d45db1f00f7797e2fc91fd. -/

namespace S13K.Chunks.C00459

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00459.txt"

theorem chk : chkChunk S N 35655 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 35655 35737 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00459
