import S13Kernel.Data.Keys

/-! Keys number 34790 to 34874. `data/c/c00449.txt` has sha256 918062ccb962306141ca91c6ac31662ee3019684c0d801ee9ae8624ddfb751cc. -/

namespace S13K.Chunks.C00449

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00449.txt"

theorem chk : chkChunk S N 34790 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 34790 34875 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00449
