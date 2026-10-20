import S13Kernel.Data.Keys

/-! Keys number 67338 to 67424. `data/c/c00797.txt` has sha256 f95ef71d9ab00615864763758bb99ca01bf3612b9d064253ac02ee9cb257a1b0. -/

namespace S13K.Chunks.C00797

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00797.txt"

theorem chk : chkChunk S N 67338 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 67338 67425 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00797
