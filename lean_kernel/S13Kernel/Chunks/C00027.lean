import S13Kernel.Data.Keys

/-! Keys number 1300 to 1368. `data/c/c00027.txt` has sha256 3e619b00241723450b105daa8404616a05170dac4bc89e05eec27fe5969f1e41. -/

namespace S13K.Chunks.C00027

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00027.txt"

theorem chk : chkChunk S N 1300 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 1300 1369 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00027
