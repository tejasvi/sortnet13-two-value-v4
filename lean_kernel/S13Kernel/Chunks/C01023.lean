import S13Kernel.Data.Keys

/-! Keys number 90594 to 90707. `data/c/c01023.txt` has sha256 2cc5f5e1b9d7a1ca9bbd073cf94617e4629e42aa1202dd7eb562ee3825214da8. -/

namespace S13K.Chunks.C01023

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01023.txt"

theorem chk : chkChunk S N 90594 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 90594 90708 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01023
