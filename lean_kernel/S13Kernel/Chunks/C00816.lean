import S13Kernel.Data.Keys

/-! Keys number 69190 to 69294. `data/c/c00816.txt` has sha256 5002153ae2b581a8cce79e6f468e01020271c86d2a9aa79e36adad48cc9f56fe. -/

namespace S13K.Chunks.C00816

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00816.txt"

theorem chk : chkChunk S N 69190 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 69190 69295 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00816
