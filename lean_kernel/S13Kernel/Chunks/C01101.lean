import S13Kernel.Data.Keys

/-! Keys number 99615 to 99735. `data/c/c01101.txt` has sha256 eb8f6bf6fc06f43b538037e389434a8d369a4b2cc3e3cad529399e538644d9e8. -/

namespace S13K.Chunks.C01101

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01101.txt"

theorem chk : chkChunk S N 99615 121 ces = true := by decide +kernel

theorem ok : RangeOK S N 99615 99736 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01101
