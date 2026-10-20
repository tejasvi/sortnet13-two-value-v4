import S13Kernel.Data.Keys

/-! Keys number 43205 to 43312. `data/c/c00541.txt` has sha256 c079379775efe9c4ec983a711c693c0a154e1a0f36722b62043691336c534927. -/

namespace S13K.Chunks.C00541

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00541.txt"

theorem chk : chkChunk S N 43205 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 43205 43313 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00541
