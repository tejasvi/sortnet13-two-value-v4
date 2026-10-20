import S13Kernel.Data.Keys

/-! Keys number 24609 to 24678. `data/c/c00332.txt` has sha256 5808a4b66f46aa5f5a0cdccd98db2a50460a2b1a8ef15525aa4e04b645ccb7ab. -/

namespace S13K.Chunks.C00332

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00332.txt"

theorem chk : chkChunk S N 24609 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 24609 24679 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00332
