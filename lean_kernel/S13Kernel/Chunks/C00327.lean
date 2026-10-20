import S13Kernel.Data.Keys

/-! Keys number 24195 to 24278. `data/c/c00327.txt` has sha256 1a8fd25aa908f0d63257fa7306b2d086f753f26bd5a34c0f686ad68f98cb2eb4. -/

namespace S13K.Chunks.C00327

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00327.txt"

theorem chk : chkChunk S N 24195 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 24195 24279 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00327
