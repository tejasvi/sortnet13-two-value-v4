import S13Kernel.Data.Keys

/-! Keys number 95159 to 95275. `data/c/c01064.txt` has sha256 99b9333c113f26039d8a32b82383c04f6d1795579c05e013b93e68b6695e0638. -/

namespace S13K.Chunks.C01064

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01064.txt"

theorem chk : chkChunk S N 95159 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 95159 95276 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01064
