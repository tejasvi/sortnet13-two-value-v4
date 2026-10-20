import S13Kernel.Data.Keys

/-! Keys number 63593 to 63714. `data/c/c00757.txt` has sha256 ebb8b8d00a9019999f465106cbd8f8a8bcc8bd51ba2e131b4deebd917c23f2cd. -/

namespace S13K.Chunks.C00757

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00757.txt"

theorem chk : chkChunk S N 63593 122 ces = true := by decide +kernel

theorem ok : RangeOK S N 63593 63715 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00757
