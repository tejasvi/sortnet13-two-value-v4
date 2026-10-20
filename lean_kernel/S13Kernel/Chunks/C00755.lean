import S13Kernel.Data.Keys

/-! Keys number 63387 to 63486. `data/c/c00755.txt` has sha256 378f0fa66e280ea223a8a27a30b0c3643991804bf2e534fc97c5a00caec940a9. -/

namespace S13K.Chunks.C00755

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00755.txt"

theorem chk : chkChunk S N 63387 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 63387 63487 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00755
