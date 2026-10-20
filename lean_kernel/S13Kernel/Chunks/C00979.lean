import S13Kernel.Data.Keys

/-! Keys number 85839 to 85946. `data/c/c00979.txt` has sha256 284e7fae827f89f33fff758e2906bead96039b60b79695e600407faf360d7271. -/

namespace S13K.Chunks.C00979

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00979.txt"

theorem chk : chkChunk S N 85839 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 85839 85947 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00979
