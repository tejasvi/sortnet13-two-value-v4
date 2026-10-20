import S13Kernel.Data.Keys

/-! Keys number 22406 to 22479. `data/c/c00308.txt` has sha256 1022c9d9ff7278691dc449f7665fc7e2945c9c778bddac95d5ce16e8a1f9bcfe. -/

namespace S13K.Chunks.C00308

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00308.txt"

theorem chk : chkChunk S N 22406 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 22406 22480 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00308
