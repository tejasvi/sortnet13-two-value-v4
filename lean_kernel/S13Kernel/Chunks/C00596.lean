import S13Kernel.Data.Keys

/-! Keys number 48469 to 48556. `data/c/c00596.txt` has sha256 c2218b44062878f7efb910fa40890385a6dc3c6992eb503575be4c744ac41c0f. -/

namespace S13K.Chunks.C00596

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00596.txt"

theorem chk : chkChunk S N 48469 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 48469 48557 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00596
