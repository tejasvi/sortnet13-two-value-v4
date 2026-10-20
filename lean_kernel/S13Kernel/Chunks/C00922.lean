import S13Kernel.Data.Keys

/-! Keys number 79929 to 80036. `data/c/c00922.txt` has sha256 f9e637d009211f74a484c7a040264fd9d5dc41ecccae1ce83f991120fd1293f1. -/

namespace S13K.Chunks.C00922

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00922.txt"

theorem chk : chkChunk S N 79929 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 79929 80037 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00922
