import S13Kernel.Data.Keys

/-! Keys number 5685 to 5742. `data/c/c00096.txt` has sha256 73547522f792face2b35b52c673f8f6b07713d44f112a0b03b8bc37b275c04db. -/

namespace S13K.Chunks.C00096

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00096.txt"

theorem chk : chkChunk S N 5685 58 ces = true := by decide +kernel

theorem ok : RangeOK S N 5685 5743 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00096
