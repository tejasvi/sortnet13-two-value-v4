import S13Kernel.Data.Keys

/-! Keys number 30837 to 30922. `data/c/c00401.txt` has sha256 ba8c5e1204f26bcc7819e05f08a44fd86a51eb11d283ecb4e64717a1fe2b85bb. -/

namespace S13K.Chunks.C00401

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00401.txt"

theorem chk : chkChunk S N 30837 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 30837 30923 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00401
