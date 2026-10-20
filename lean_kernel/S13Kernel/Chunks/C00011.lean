import S13Kernel.Data.Keys

/-! Keys number 455 to 509. `data/c/c00011.txt` has sha256 c57ac5458a88e788d4ab65125733dcf9b0723bec6b78ff6bb558df0ad460fcfe. -/

namespace S13K.Chunks.C00011

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00011.txt"

theorem chk : chkChunk S N 455 55 ces = true := by decide +kernel

theorem ok : RangeOK S N 455 510 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00011
