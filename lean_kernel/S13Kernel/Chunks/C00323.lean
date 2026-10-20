import S13Kernel.Data.Keys

/-! Keys number 23788 to 23894. `data/c/c00323.txt` has sha256 4bb4288b2a0a782fa3a3c271e5aefd9b536c982c6c32c07d09fdcb5ba0261a9f. -/

namespace S13K.Chunks.C00323

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00323.txt"

theorem chk : chkChunk S N 23788 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 23788 23895 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00323
