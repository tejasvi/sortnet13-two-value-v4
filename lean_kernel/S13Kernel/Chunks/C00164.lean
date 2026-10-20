import S13Kernel.Data.Keys

/-! Keys number 10870 to 10932. `data/c/c00164.txt` has sha256 cc416d47dd45e9f303bb0f49b3df595453da107e8c1f393ff4d7f14caa94fccd. -/

namespace S13K.Chunks.C00164

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00164.txt"

theorem chk : chkChunk S N 10870 63 ces = true := by decide +kernel

theorem ok : RangeOK S N 10870 10933 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00164
