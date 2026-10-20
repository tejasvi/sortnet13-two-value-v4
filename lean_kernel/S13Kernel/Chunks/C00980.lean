import S13Kernel.Data.Keys

/-! Keys number 85947 to 86051. `data/c/c00980.txt` has sha256 a883f13d9ef3d143540c08d0ddcca590aef954a9fb69b2f2f2e6463a5b887a84. -/

namespace S13K.Chunks.C00980

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00980.txt"

theorem chk : chkChunk S N 85947 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 85947 86052 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00980
