import S13Kernel.Data.Keys

/-! Keys number 31635 to 31726. `data/c/c00410.txt` has sha256 d6275b0539064f6b2bbb5e946ec7d91dca91354a27fb8e7fdcec06dc7cd5eaab. -/

namespace S13K.Chunks.C00410

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00410.txt"

theorem chk : chkChunk S N 31635 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 31635 31727 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00410
