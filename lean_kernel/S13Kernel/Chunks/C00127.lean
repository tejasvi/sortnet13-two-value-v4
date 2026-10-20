import S13Kernel.Data.Keys

/-! Keys number 7990 to 8069. `data/c/c00127.txt` has sha256 357ccaf7ec7cf9ee270f45d75c2fe7028460ae572556c553fc4f571d33423668. -/

namespace S13K.Chunks.C00127

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00127.txt"

theorem chk : chkChunk S N 7990 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 7990 8070 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00127
