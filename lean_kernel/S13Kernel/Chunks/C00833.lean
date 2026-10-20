import S13Kernel.Data.Keys

/-! Keys number 70899 to 70994. `data/c/c00833.txt` has sha256 87eb0f81e8ab1b5ddc3c5b18d8d45bce85dde30eb2c4ab37071dfcf55aa03c0a. -/

namespace S13K.Chunks.C00833

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00833.txt"

theorem chk : chkChunk S N 70899 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 70899 70995 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00833
