import S13Kernel.Data.Keys

/-! Keys number 53963 to 54054. `data/c/c00658.txt` has sha256 a17f08d7fa6de3ef6eeb36066de180b66b02b933b6983ccd644e3375910168ff. -/

namespace S13K.Chunks.C00658

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00658.txt"

theorem chk : chkChunk S N 53963 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 53963 54055 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00658
