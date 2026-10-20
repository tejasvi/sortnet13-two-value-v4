import S13Kernel.Data.Keys

/-! Keys number 85322 to 85437. `data/c/c00974.txt` has sha256 990d5ebd13dcd25805bae8a0cc0e5b9a34012fe2852cf607567cafa295074911. -/

namespace S13K.Chunks.C00974

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00974.txt"

theorem chk : chkChunk S N 85322 116 ces = true := by decide +kernel

theorem ok : RangeOK S N 85322 85438 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00974
