import S13Kernel.Data.Keys

/-! Keys number 22005 to 22081. `data/c/c00303.txt` has sha256 2e6b2ffde186c640ee7ec3eeb7f9e4fef4369a9ff2848dc0694596ee917dcb17. -/

namespace S13K.Chunks.C00303

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00303.txt"

theorem chk : chkChunk S N 22005 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 22005 22082 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00303
