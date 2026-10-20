import S13Kernel.Data.Keys

/-! Keys number 75200 to 75309. `data/c/c00877.txt` has sha256 c8f7bd4e51ac5935ed6e6b4f26dc7d469aa97df8eee33b18f781f3e8b237e941. -/

namespace S13K.Chunks.C00877

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00877.txt"

theorem chk : chkChunk S N 75200 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 75200 75310 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00877
