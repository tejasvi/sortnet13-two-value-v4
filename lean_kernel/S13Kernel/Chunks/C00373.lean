import S13Kernel.Data.Keys

/-! Keys number 28234 to 28316. `data/c/c00373.txt` has sha256 a6e5eb12eb941012dd47a32e407f00c27d17374e1c6490c3181a1d69c13fecf8. -/

namespace S13K.Chunks.C00373

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00373.txt"

theorem chk : chkChunk S N 28234 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 28234 28317 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00373
