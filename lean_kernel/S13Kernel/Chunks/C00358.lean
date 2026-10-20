import S13Kernel.Data.Keys

/-! Keys number 26820 to 26890. `data/c/c00358.txt` has sha256 495ce965a7259bc24d1cda7eefd7529c445e57cdfd075b868230c0b2cdff9902. -/

namespace S13K.Chunks.C00358

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00358.txt"

theorem chk : chkChunk S N 26820 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 26820 26891 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00358
