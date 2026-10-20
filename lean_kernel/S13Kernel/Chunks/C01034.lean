import S13Kernel.Data.Keys

/-! Keys number 91803 to 91912. `data/c/c01034.txt` has sha256 1411bb365fdb16928c9cb70793248c4f0eb1b80ff19fbd5305186e6815f8c9e5. -/

namespace S13K.Chunks.C01034

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01034.txt"

theorem chk : chkChunk S N 91803 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 91803 91913 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01034
