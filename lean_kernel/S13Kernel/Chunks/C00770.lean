import S13Kernel.Data.Keys

/-! Keys number 64890 to 65004. `data/c/c00770.txt` has sha256 c66c0dc5324c94fb52f8cef899b74f0588f7dca5c52cc1f8e5ab16f320dd2e19. -/

namespace S13K.Chunks.C00770

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00770.txt"

theorem chk : chkChunk S N 64890 115 ces = true := by decide +kernel

theorem ok : RangeOK S N 64890 65005 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00770
