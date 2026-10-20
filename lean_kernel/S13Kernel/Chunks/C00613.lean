import S13Kernel.Data.Keys

/-! Keys number 49874 to 49947. `data/c/c00613.txt` has sha256 2e143da339dbd5880e23276a1ede084aa51c5cd4ceab41b6d0a1eb2dd14046de. -/

namespace S13K.Chunks.C00613

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00613.txt"

theorem chk : chkChunk S N 49874 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 49874 49948 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00613
