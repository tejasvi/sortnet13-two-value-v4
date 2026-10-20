import S13Kernel.Data.Keys

/-! Keys number 277 to 328. `data/c/c00007.txt` has sha256 2f3f253088b738230a05599026fd78d76cc2b2fecd989cb5d4f55e6d3da126ea. -/

namespace S13K.Chunks.C00007

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00007.txt"

theorem chk : chkChunk S N 277 52 ces = true := by decide +kernel

theorem ok : RangeOK S N 277 329 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00007
