import S13Kernel.Data.Keys

/-! Keys number 69946 to 70041. `data/c/c00823.txt` has sha256 0dc5bbb4a35446b9582274994e0bdded855ef83e1f4d4109130bf8ee7e9148a1. -/

namespace S13K.Chunks.C00823

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00823.txt"

theorem chk : chkChunk S N 69946 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 69946 70042 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00823
