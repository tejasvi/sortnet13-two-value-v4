import S13Kernel.Data.Keys

/-! Keys number 22082 to 22161. `data/c/c00304.txt` has sha256 6e459c5c258564960605da423987ababcffa353a38a1055bcc6ebbf5b36d07c7. -/

namespace S13K.Chunks.C00304

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00304.txt"

theorem chk : chkChunk S N 22082 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 22082 22162 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00304
