import S13Kernel.Data.Keys

/-! Keys number 44530 to 44614. `data/c/c00554.txt` has sha256 f5a97e0aa911f0f0ebb8600ea6e740f82ad90a3b2455cf86bf91f26b7c0e40db. -/

namespace S13K.Chunks.C00554

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00554.txt"

theorem chk : chkChunk S N 44530 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 44530 44615 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00554
