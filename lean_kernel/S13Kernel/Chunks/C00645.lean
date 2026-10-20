import S13Kernel.Data.Keys

/-! Keys number 52745 to 52858. `data/c/c00645.txt` has sha256 bc53ba369affee957b59a6408b35ec3eeaf469b7896148e50dafc03408c97535. -/

namespace S13K.Chunks.C00645

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00645.txt"

theorem chk : chkChunk S N 52745 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 52745 52859 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00645
