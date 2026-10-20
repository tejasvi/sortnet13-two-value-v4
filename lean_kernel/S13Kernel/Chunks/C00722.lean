import S13Kernel.Data.Keys

/-! Keys number 60136 to 60244. `data/c/c00722.txt` has sha256 b840b4ac83fee0cc61358e803c917dba197703c46207d52096cddb73487320dd. -/

namespace S13K.Chunks.C00722

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00722.txt"

theorem chk : chkChunk S N 60136 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 60136 60245 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00722
