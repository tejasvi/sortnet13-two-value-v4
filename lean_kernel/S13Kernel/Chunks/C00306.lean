import S13Kernel.Data.Keys

/-! Keys number 22236 to 22326. `data/c/c00306.txt` has sha256 f909c56143500ea010dcac5e28fb19eafa99dd94f568250fec705f3e272dec6f. -/

namespace S13K.Chunks.C00306

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00306.txt"

theorem chk : chkChunk S N 22236 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 22236 22327 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00306
