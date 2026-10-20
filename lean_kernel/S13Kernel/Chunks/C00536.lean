import S13Kernel.Data.Keys

/-! Keys number 42681 to 42787. `data/c/c00536.txt` has sha256 48ac8c3f18ef23067a541b29c91d484f04e1d8641009069ea7cee894085cb672. -/

namespace S13K.Chunks.C00536

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00536.txt"

theorem chk : chkChunk S N 42681 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 42681 42788 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00536
