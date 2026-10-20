import S13Kernel.Data.Keys

/-! Keys number 45065 to 45162. `data/c/c00560.txt` has sha256 cc6d4b0378a8963c0bbbcf3f69831435d71e5cb023e2e36291f6555ac2c68c47. -/

namespace S13K.Chunks.C00560

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00560.txt"

theorem chk : chkChunk S N 45065 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 45065 45163 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00560
