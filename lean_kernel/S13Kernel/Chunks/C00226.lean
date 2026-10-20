import S13Kernel.Data.Keys

/-! Keys number 15710 to 15792. `data/c/c00226.txt` has sha256 05daa7aff5f6a5f6a660dbaa1bed8056af2e9b54fa54c2956a990af47bae8330. -/

namespace S13K.Chunks.C00226

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00226.txt"

theorem chk : chkChunk S N 15710 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 15710 15793 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00226
