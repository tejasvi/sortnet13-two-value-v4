import S13Kernel.Data.Keys

/-! Keys number 26967 to 27061. `data/c/c00360.txt` has sha256 95b44105297ce34440957544a92eb1626da1408c95ed4c285b2fa21d73257db8. -/

namespace S13K.Chunks.C00360

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00360.txt"

theorem chk : chkChunk S N 26967 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 26967 27062 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00360
