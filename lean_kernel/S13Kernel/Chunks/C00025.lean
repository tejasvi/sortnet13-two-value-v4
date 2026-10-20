import S13Kernel.Data.Keys

/-! Keys number 1168 to 1231. `data/c/c00025.txt` has sha256 675f39789294b1eb24967cc6c78e78798730099290f204348c538dbb56db863e. -/

namespace S13K.Chunks.C00025

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00025.txt"

theorem chk : chkChunk S N 1168 64 ces = true := by decide +kernel

theorem ok : RangeOK S N 1168 1232 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00025
