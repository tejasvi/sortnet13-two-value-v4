import S13Kernel.Data.Keys

/-! Keys number 98977 to 99102. `data/c/c01096.txt` has sha256 52eece841d9e40f8e08217f4809d5d56c8df371fdbbc2d4a16cef7617c998ed2. -/

namespace S13K.Chunks.C01096

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01096.txt"

theorem chk : chkChunk S N 98977 126 ces = true := by decide +kernel

theorem ok : RangeOK S N 98977 99103 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01096
