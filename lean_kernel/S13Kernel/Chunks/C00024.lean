import S13Kernel.Data.Keys

/-! Keys number 1111 to 1167. `data/c/c00024.txt` has sha256 c6595bf22a2d8474edc7e48b24e0645d422d2354ebfc2bdbcd50f55255166d89. -/

namespace S13K.Chunks.C00024

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00024.txt"

theorem chk : chkChunk S N 1111 57 ces = true := by decide +kernel

theorem ok : RangeOK S N 1111 1168 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00024
