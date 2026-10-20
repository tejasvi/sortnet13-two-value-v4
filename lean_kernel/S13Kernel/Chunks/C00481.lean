import S13Kernel.Data.Keys

/-! Keys number 37628 to 37738. `data/c/c00481.txt` has sha256 b0580cb8d4765f7924df05d3e9beaf64f4b63b1b6d4ba6c28b18b97b37fd808b. -/

namespace S13K.Chunks.C00481

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00481.txt"

theorem chk : chkChunk S N 37628 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 37628 37739 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00481
