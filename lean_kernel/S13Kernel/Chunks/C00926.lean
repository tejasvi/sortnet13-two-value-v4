import S13Kernel.Data.Keys

/-! Keys number 80372 to 80465. `data/c/c00926.txt` has sha256 9f358e07d2db27771f8704831a99451e175d3d59a964317f0f5f4d768cc4334a. -/

namespace S13K.Chunks.C00926

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00926.txt"

theorem chk : chkChunk S N 80372 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 80372 80466 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00926
