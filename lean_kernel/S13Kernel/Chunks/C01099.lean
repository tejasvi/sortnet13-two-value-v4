import S13Kernel.Data.Keys

/-! Keys number 99357 to 99485. `data/c/c01099.txt` has sha256 a3f29c340e50ebc5a0f21f4a500e42a7b815da39f7bc130fbe32244c2cff0e26. -/

namespace S13K.Chunks.C01099

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01099.txt"

theorem chk : chkChunk S N 99357 129 ces = true := by decide +kernel

theorem ok : RangeOK S N 99357 99486 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01099
