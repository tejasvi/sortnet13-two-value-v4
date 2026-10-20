import S13Kernel.Data.Keys

/-! Keys number 96931 to 97049. `data/c/c01079.txt` has sha256 9e0c54549ead434d78dd78cc6221a56cc4a93e50444f0150b2e1a951680536d5. -/

namespace S13K.Chunks.C01079

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01079.txt"

theorem chk : chkChunk S N 96931 119 ces = true := by decide +kernel

theorem ok : RangeOK S N 96931 97050 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01079
