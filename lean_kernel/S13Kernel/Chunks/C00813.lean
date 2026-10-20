import S13Kernel.Data.Keys

/-! Keys number 68888 to 68991. `data/c/c00813.txt` has sha256 b50bb6062d9bcb71c99ff47857eca1ef95446c9696f66d8c8dbeebd8b3aa441a. -/

namespace S13K.Chunks.C00813

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00813.txt"

theorem chk : chkChunk S N 68888 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 68888 68992 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00813
