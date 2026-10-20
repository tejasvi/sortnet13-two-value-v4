import S13Kernel.Data.Keys

/-! Keys number 56168 to 56261. `data/c/c00681.txt` has sha256 b38b5b4e8e06ef6a83edaa8829510f974a4ab2a9e79b3d3a503d016354ef3e54. -/

namespace S13K.Chunks.C00681

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00681.txt"

theorem chk : chkChunk S N 56168 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 56168 56262 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00681
