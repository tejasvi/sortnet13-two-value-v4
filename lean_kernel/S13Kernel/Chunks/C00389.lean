import S13Kernel.Data.Keys

/-! Keys number 29732 to 29814. `data/c/c00389.txt` has sha256 ee7bc7750d32e9ebac45dd8a16bcf4c0fa12a1ba906fb6dc12fc9ac355b68aef. -/

namespace S13K.Chunks.C00389

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00389.txt"

theorem chk : chkChunk S N 29732 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 29732 29815 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00389
