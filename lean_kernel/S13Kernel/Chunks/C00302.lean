import S13Kernel.Data.Keys

/-! Keys number 21921 to 22004. `data/c/c00302.txt` has sha256 e413173ef0481934ec7585def07630250894b8b53131df5baa7fb69b70c06e1f. -/

namespace S13K.Chunks.C00302

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00302.txt"

theorem chk : chkChunk S N 21921 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 21921 22005 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00302
