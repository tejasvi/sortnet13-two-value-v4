import S13Kernel.Data.Keys

/-! Keys number 2208 to 2269. `data/c/c00042.txt` has sha256 1f2956e45e92b281b8980a995f4520bbf096b3be8decd5b3b2ced2403d8ab196. -/

namespace S13K.Chunks.C00042

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00042.txt"

theorem chk : chkChunk S N 2208 62 ces = true := by decide +kernel

theorem ok : RangeOK S N 2208 2270 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00042
