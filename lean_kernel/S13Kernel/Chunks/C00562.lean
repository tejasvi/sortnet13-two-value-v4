import S13Kernel.Data.Keys

/-! Keys number 45251 to 45340. `data/c/c00562.txt` has sha256 64e5d967c5a5ff1bbd1db707729d52b0e05e7966146a657091117c08ee5218d6. -/

namespace S13K.Chunks.C00562

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00562.txt"

theorem chk : chkChunk S N 45251 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 45251 45341 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00562
