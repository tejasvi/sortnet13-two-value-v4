import S13Kernel.Data.Keys

/-! Keys number 67612 to 67706. `data/c/c00800.txt` has sha256 997e667dad7301ec23d9b1f45eb1b809dcbcbfc8288074ef750963965893704a. -/

namespace S13K.Chunks.C00800

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00800.txt"

theorem chk : chkChunk S N 67612 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 67612 67707 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00800
