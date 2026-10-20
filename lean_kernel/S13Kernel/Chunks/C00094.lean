import S13Kernel.Data.Keys

/-! Keys number 5582 to 5633. `data/c/c00094.txt` has sha256 546772b361bffaa277de197643cfc82c40a04535f8669efd038556126d9416a1. -/

namespace S13K.Chunks.C00094

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00094.txt"

theorem chk : chkChunk S N 5582 52 ces = true := by decide +kernel

theorem ok : RangeOK S N 5582 5634 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00094
