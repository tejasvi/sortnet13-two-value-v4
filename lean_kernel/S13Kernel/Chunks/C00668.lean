import S13Kernel.Data.Keys

/-! Keys number 55016 to 55109. `data/c/c00668.txt` has sha256 e046c10bbf036f5fc96e2bd54696b9f3ef6b8b4387d6e740f3fb42a99b830dc1. -/

namespace S13K.Chunks.C00668

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00668.txt"

theorem chk : chkChunk S N 55016 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 55016 55110 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00668
