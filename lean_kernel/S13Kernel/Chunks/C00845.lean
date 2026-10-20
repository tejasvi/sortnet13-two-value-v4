import S13Kernel.Data.Keys

/-! Keys number 72113 to 72199. `data/c/c00845.txt` has sha256 63bb6f1ebf7d83f566bcc848e1432c5278136e6a058dbdeccd2934d15cb262f7. -/

namespace S13K.Chunks.C00845

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00845.txt"

theorem chk : chkChunk S N 72113 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 72113 72200 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00845
