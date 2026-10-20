import S13Kernel.Data.Keys

/-! Keys number 27435 to 27539. `data/c/c00365.txt` has sha256 b453d31e2d5e19fc18cc4bb9789bb4aaf502c9be7d65d82d807ba85b0f910ea2. -/

namespace S13K.Chunks.C00365

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00365.txt"

theorem chk : chkChunk S N 27435 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 27435 27540 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00365
