import S13Kernel.Data.Keys

/-! Keys number 94826 to 94942. `data/c/c01061.txt` has sha256 23b9f7a712102175c3b1ee436221323c9952df393a97d308b1de5c932176049e. -/

namespace S13K.Chunks.C01061

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01061.txt"

theorem chk : chkChunk S N 94826 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 94826 94943 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01061
