import S13Kernel.Data.Keys

/-! Keys number 52263 to 52349. `data/c/c00640.txt` has sha256 1b747102b36ffa6ecdcf7e98c01e1d412054661b51a5b1ed14a433b2f8befa16. -/

namespace S13K.Chunks.C00640

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00640.txt"

theorem chk : chkChunk S N 52263 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 52263 52350 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00640
