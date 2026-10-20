import S13Kernel.Data.Keys

/-! Keys number 40998 to 41096. `data/c/c00518.txt` has sha256 1f14bcb193fd9568a6f6994a87d58f8bd7dec3dacc1305e7d72d44db0066906a. -/

namespace S13K.Chunks.C00518

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00518.txt"

theorem chk : chkChunk S N 40998 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 40998 41097 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00518
