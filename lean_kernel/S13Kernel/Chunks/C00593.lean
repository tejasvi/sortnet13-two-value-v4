import S13Kernel.Data.Keys

/-! Keys number 48160 to 48270. `data/c/c00593.txt` has sha256 ed72d5b65b2cd5c58b15ba34282973a30467e949154c3955f930bfcbde56c24d. -/

namespace S13K.Chunks.C00593

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00593.txt"

theorem chk : chkChunk S N 48160 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 48160 48271 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00593
