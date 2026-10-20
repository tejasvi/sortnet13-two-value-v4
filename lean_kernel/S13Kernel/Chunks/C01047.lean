import S13Kernel.Data.Keys

/-! Keys number 93231 to 93345. `data/c/c01047.txt` has sha256 18150f484880895ec45680c2fa9dec74469c8a8fab065ab356d20f964faea131. -/

namespace S13K.Chunks.C01047

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01047.txt"

theorem chk : chkChunk S N 93231 115 ces = true := by decide +kernel

theorem ok : RangeOK S N 93231 93346 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01047
