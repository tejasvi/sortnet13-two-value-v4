import S13Kernel.Data.Keys

/-! Keys number 13931 to 14024. `data/c/c00204.txt` has sha256 d5d44ee1d9e9e0619a0b4bea4556803d9e487fb0a555f370733261321dceaab5. -/

namespace S13K.Chunks.C00204

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00204.txt"

theorem chk : chkChunk S N 13931 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 13931 14025 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00204
