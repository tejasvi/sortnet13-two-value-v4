import S13Kernel.Data.Keys

/-! Keys number 42231 to 42327. `data/c/c00531.txt` has sha256 a746578c8b0d2e0dea6c1e5e8aff35fe660917b8307a088b5357aad804dba56a. -/

namespace S13K.Chunks.C00531

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00531.txt"

theorem chk : chkChunk S N 42231 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 42231 42328 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00531
