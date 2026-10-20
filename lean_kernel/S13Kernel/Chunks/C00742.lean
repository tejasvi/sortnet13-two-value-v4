import S13Kernel.Data.Keys

/-! Keys number 62147 to 62258. `data/c/c00742.txt` has sha256 c5072c85083e1c0d5bff567ebf82f39d0ae9a8493e4bcbf17e878455ee44650f. -/

namespace S13K.Chunks.C00742

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00742.txt"

theorem chk : chkChunk S N 62147 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 62147 62259 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00742
