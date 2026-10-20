import S13Kernel.Data.Keys

/-! Keys number 93824 to 93928. `data/c/c01052.txt` has sha256 36a9c0753d440c13ff7b28ec53ffb367ded393a7027b4327be141871e84bfcbb. -/

namespace S13K.Chunks.C01052

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01052.txt"

theorem chk : chkChunk S N 93824 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 93824 93929 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01052
