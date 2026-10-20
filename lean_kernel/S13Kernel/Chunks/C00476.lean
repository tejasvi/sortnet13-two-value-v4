import S13Kernel.Data.Keys

/-! Keys number 37146 to 37244. `data/c/c00476.txt` has sha256 a71d020fd286af5c7b6125e0d26361172806da7c375cb47ee4d19f237d5e6341. -/

namespace S13K.Chunks.C00476

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00476.txt"

theorem chk : chkChunk S N 37146 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 37146 37245 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00476
