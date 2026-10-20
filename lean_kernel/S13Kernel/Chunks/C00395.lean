import S13Kernel.Data.Keys

/-! Keys number 30264 to 30353. `data/c/c00395.txt` has sha256 c86f360e6b24f9031f207c5a8211d883a3ee60e27bd1b241019380639fa31c1c. -/

namespace S13K.Chunks.C00395

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00395.txt"

theorem chk : chkChunk S N 30264 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 30264 30354 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00395
