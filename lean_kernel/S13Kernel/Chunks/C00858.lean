import S13Kernel.Data.Keys

/-! Keys number 73303 to 73397. `data/c/c00858.txt` has sha256 c6c4a4eccd36a5a463b2cca25fbe9420248fca6cd43ba46527dd6b7a6bfe3d46. -/

namespace S13K.Chunks.C00858

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00858.txt"

theorem chk : chkChunk S N 73303 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 73303 73398 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00858
