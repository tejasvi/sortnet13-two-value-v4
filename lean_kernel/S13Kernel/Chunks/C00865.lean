import S13Kernel.Data.Keys

/-! Keys number 73964 to 74053. `data/c/c00865.txt` has sha256 889b7ba84178e969a515c39c4500c5592d00b23396720c9a6f05e811ebd79bf8. -/

namespace S13K.Chunks.C00865

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00865.txt"

theorem chk : chkChunk S N 73964 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 73964 74054 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00865
