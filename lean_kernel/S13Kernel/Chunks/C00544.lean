import S13Kernel.Data.Keys

/-! Keys number 43525 to 43621. `data/c/c00544.txt` has sha256 1798c1161e03bc8eaa947200696cbd2393d0b9ca9a6c722643245f9825f4f9c3. -/

namespace S13K.Chunks.C00544

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00544.txt"

theorem chk : chkChunk S N 43525 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 43525 43622 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00544
