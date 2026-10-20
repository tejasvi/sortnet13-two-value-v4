import S13Kernel.Data.Keys

/-! Keys number 57039 to 57130. `data/c/c00691.txt` has sha256 3a388d459e2ac0bde65d8f0fee71fb5fb079879edd2fdd24cb9484e5621c6690. -/

namespace S13K.Chunks.C00691

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00691.txt"

theorem chk : chkChunk S N 57039 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 57039 57131 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00691
