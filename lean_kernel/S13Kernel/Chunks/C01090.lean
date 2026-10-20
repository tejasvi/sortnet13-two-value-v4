import S13Kernel.Data.Keys

/-! Keys number 98240 to 98359. `data/c/c01090.txt` has sha256 ea6e65a3a2ed488e29a355f7db02df3492d522118a52da00bc7760bdcfada2ae. -/

namespace S13K.Chunks.C01090

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01090.txt"

theorem chk : chkChunk S N 98240 120 ces = true := by decide +kernel

theorem ok : RangeOK S N 98240 98360 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01090
