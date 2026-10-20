import S13Kernel.Data.Keys

/-! Keys number 96810 to 96930. `data/c/c01078.txt` has sha256 63e848ec94162ee1039c2f55d23deb818a56dd36831e5f32d814c9e6243b1479. -/

namespace S13K.Chunks.C01078

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01078.txt"

theorem chk : chkChunk S N 96810 121 ces = true := by decide +kernel

theorem ok : RangeOK S N 96810 96931 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01078
