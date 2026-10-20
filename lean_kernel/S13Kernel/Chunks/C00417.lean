import S13Kernel.Data.Keys

/-! Keys number 32247 to 32333. `data/c/c00417.txt` has sha256 3137aad4862f953d4f1681f06863c42bfe36f37f1918b0221ef140d6a0352547. -/

namespace S13K.Chunks.C00417

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00417.txt"

theorem chk : chkChunk S N 32247 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 32247 32334 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00417
