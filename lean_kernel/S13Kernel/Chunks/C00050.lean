import S13Kernel.Data.Keys

/-! Keys number 2621 to 2675. `data/c/c00050.txt` has sha256 c2296ef7f917ec7b82e380676052958e81e903fe45d318499354b6d0a049c651. -/

namespace S13K.Chunks.C00050

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00050.txt"

theorem chk : chkChunk S N 2621 55 ces = true := by decide +kernel

theorem ok : RangeOK S N 2621 2676 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00050
