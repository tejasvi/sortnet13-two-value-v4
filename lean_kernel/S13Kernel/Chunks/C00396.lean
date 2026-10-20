import S13Kernel.Data.Keys

/-! Keys number 30354 to 30453. `data/c/c00396.txt` has sha256 0a02fb7d0ebaf9bd6de64ff3140971268af557629e0959bd037b5678d0242588. -/

namespace S13K.Chunks.C00396

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00396.txt"

theorem chk : chkChunk S N 30354 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 30354 30454 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00396
