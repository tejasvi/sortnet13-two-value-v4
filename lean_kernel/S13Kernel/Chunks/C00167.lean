import S13Kernel.Data.Keys

/-! Keys number 11054 to 11109. `data/c/c00167.txt` has sha256 c245d535a9f9703c463ae17cd270f38d51a9db75bbf196c0d997b498128ad82d. -/

namespace S13K.Chunks.C00167

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00167.txt"

theorem chk : chkChunk S N 11054 56 ces = true := by decide +kernel

theorem ok : RangeOK S N 11054 11110 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00167
