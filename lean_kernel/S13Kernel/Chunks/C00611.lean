import S13Kernel.Data.Keys

/-! Keys number 49707 to 49789. `data/c/c00611.txt` has sha256 850678156e72b7bd51faa060dd6cf8196820980f830f934b3076af93be780d08. -/

namespace S13K.Chunks.C00611

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00611.txt"

theorem chk : chkChunk S N 49707 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 49707 49790 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00611
