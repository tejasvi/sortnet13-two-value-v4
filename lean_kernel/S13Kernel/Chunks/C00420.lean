import S13Kernel.Data.Keys

/-! Keys number 32529 to 32614. `data/c/c00420.txt` has sha256 420edc9243cab353aa9faca85533b054e5635a44148d5a8efe9d1155a9a53230. -/

namespace S13K.Chunks.C00420

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00420.txt"

theorem chk : chkChunk S N 32529 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 32529 32615 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00420
