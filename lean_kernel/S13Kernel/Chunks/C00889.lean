import S13Kernel.Data.Keys

/-! Keys number 76523 to 76621. `data/c/c00889.txt` has sha256 48d1691a6616b46e547ba1e471e508ca3435845939f1c61bec5e3e9eaba11f3a. -/

namespace S13K.Chunks.C00889

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00889.txt"

theorem chk : chkChunk S N 76523 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 76523 76622 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00889
