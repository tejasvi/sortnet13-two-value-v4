import S13Kernel.Data.Keys

/-! Keys number 75310 to 75413. `data/c/c00878.txt` has sha256 b7e04f5fb8f7b21c0bfc09972a27d948f32908f99a3d5362f0dff9c9d1f2a0f7. -/

namespace S13K.Chunks.C00878

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00878.txt"

theorem chk : chkChunk S N 75310 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 75310 75414 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00878
