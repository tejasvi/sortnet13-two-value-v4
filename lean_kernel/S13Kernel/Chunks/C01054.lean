import S13Kernel.Data.Keys

/-! Keys number 94044 to 94149. `data/c/c01054.txt` has sha256 4259ba6a05c2ea40a0b3ecb2ee25464064982f9df1f70923cfcbf798a05e23cf. -/

namespace S13K.Chunks.C01054

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01054.txt"

theorem chk : chkChunk S N 94044 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 94044 94150 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01054
