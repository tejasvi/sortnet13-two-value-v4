import S13Kernel.Data.Keys

/-! Keys number 8383 to 8453. `data/c/c00132.txt` has sha256 7c7c2f62d68bc1fb2765a3d7eae58b2b6ab0e945a94a2e9cb9639d12ea3511f9. -/

namespace S13K.Chunks.C00132

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00132.txt"

theorem chk : chkChunk S N 8383 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 8383 8454 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00132
