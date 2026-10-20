import S13Kernel.Data.Keys

/-! Keys number 8454 to 8529. `data/c/c00133.txt` has sha256 6c1a6ae70fc1df37e80cf1613ee1f24709f703d475a98f2bfaf93d87ccea7038. -/

namespace S13K.Chunks.C00133

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00133.txt"

theorem chk : chkChunk S N 8454 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 8454 8530 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00133
