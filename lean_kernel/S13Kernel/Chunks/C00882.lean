import S13Kernel.Data.Keys

/-! Keys number 75746 to 75866. `data/c/c00882.txt` has sha256 f312d5ece0ac379e932e5382fba70d2dad6e890154e4fbb058e3ffebfa5a9e5e. -/

namespace S13K.Chunks.C00882

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00882.txt"

theorem chk : chkChunk S N 75746 121 ces = true := by decide +kernel

theorem ok : RangeOK S N 75746 75867 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00882
