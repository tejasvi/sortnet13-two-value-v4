import S13Kernel.Data.Keys

/-! Keys number 62037 to 62146. `data/c/c00741.txt` has sha256 3462a4b475b06029ae5d053bff3904169ad63ab4490624c7a9f851a800f372e4. -/

namespace S13K.Chunks.C00741

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00741.txt"

theorem chk : chkChunk S N 62037 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 62037 62147 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00741
