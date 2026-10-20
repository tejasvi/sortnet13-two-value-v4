import S13Kernel.Data.Keys

/-! Keys number 44615 to 44703. `data/c/c00555.txt` has sha256 86403cbb378118892fc7a61fdb0114759277d9ae26619140e3f388e691cb9ae7. -/

namespace S13K.Chunks.C00555

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00555.txt"

theorem chk : chkChunk S N 44615 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 44615 44704 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00555
