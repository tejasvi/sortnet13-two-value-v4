import S13Kernel.Data.Keys

/-! Keys number 88477 to 88596. `data/c/c01004.txt` has sha256 5e25d20e57a42dbf63cf759e624f9c894c26ba13c1569661a5aa89e3de7a2864. -/

namespace S13K.Chunks.C01004

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01004.txt"

theorem chk : chkChunk S N 88477 120 ces = true := by decide +kernel

theorem ok : RangeOK S N 88477 88597 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01004
