import S13Kernel.Data.Keys

/-! Keys number 62921 to 63005. `data/c/c00750.txt` has sha256 369a3c24708c48c6bad62c1d83766aa8ba78392c128a0ba8db3584fdf6c315d9. -/

namespace S13K.Chunks.C00750

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00750.txt"

theorem chk : chkChunk S N 62921 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 62921 63006 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00750
