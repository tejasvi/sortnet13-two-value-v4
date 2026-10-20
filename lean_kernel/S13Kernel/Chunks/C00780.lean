import S13Kernel.Data.Keys

/-! Keys number 65806 to 65888. `data/c/c00780.txt` has sha256 d0fa754a0b9bd4c7c4bf45401096b7b2272f2a5c7821139697b5ed28fc383960. -/

namespace S13K.Chunks.C00780

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00780.txt"

theorem chk : chkChunk S N 65806 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 65806 65889 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00780
