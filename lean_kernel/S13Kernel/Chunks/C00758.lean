import S13Kernel.Data.Keys

/-! Keys number 63715 to 63812. `data/c/c00758.txt` has sha256 5e2cd5086196e7842470d3fb032593cbf1f273073869fdf0b2c4bd10a0915e99. -/

namespace S13K.Chunks.C00758

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00758.txt"

theorem chk : chkChunk S N 63715 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 63715 63813 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00758
