import S13Kernel.Data.Keys

/-! Keys number 62568 to 62648. `data/c/c00746.txt` has sha256 780aa8e9edcf9a097e918299fff2ee97a6e169ab2635423a2e822b6ba7b35655. -/

namespace S13K.Chunks.C00746

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00746.txt"

theorem chk : chkChunk S N 62568 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 62568 62649 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00746
