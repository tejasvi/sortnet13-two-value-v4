import S13Kernel.Data.Keys

/-! Keys number 32615 to 32713. `data/c/c00421.txt` has sha256 3a9e9cf26a83b32bab1bd9c752dd61dc40f08de0e11bbd6a106daa242ab150d1. -/

namespace S13K.Chunks.C00421

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00421.txt"

theorem chk : chkChunk S N 32615 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 32615 32714 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00421
