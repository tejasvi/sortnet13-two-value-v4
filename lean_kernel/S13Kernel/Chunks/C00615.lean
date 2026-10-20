import S13Kernel.Data.Keys

/-! Keys number 50035 to 50113. `data/c/c00615.txt` has sha256 d13d6acaaff007d575fd8a1d5fde9883a09bf39c1eff5fa1235bd6b8a5df94de. -/

namespace S13K.Chunks.C00615

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00615.txt"

theorem chk : chkChunk S N 50035 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 50035 50114 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00615
