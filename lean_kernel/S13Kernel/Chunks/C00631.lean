import S13Kernel.Data.Keys

/-! Keys number 51430 to 51506. `data/c/c00631.txt` has sha256 11989ec07f0a365654f2f1c94748ff6616ae8bfda217f9dbf5eb249f2bccc87f. -/

namespace S13K.Chunks.C00631

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00631.txt"

theorem chk : chkChunk S N 51430 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 51430 51507 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00631
