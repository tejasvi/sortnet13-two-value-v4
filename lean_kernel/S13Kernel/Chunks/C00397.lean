import S13Kernel.Data.Keys

/-! Keys number 30454 to 30563. `data/c/c00397.txt` has sha256 1df6e7eab1a175c56217950835eb581b7efee6f27047e3e884db80bb29334075. -/

namespace S13K.Chunks.C00397

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00397.txt"

theorem chk : chkChunk S N 30454 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 30454 30564 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00397
