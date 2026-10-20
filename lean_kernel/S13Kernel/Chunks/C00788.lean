import S13Kernel.Data.Keys

/-! Keys number 66521 to 66610. `data/c/c00788.txt` has sha256 7cc2c9458fbf34f0938e92ae9b0b35ab03f139f73768ea487a0e3b7189923f59. -/

namespace S13K.Chunks.C00788

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00788.txt"

theorem chk : chkChunk S N 66521 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 66521 66611 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00788
