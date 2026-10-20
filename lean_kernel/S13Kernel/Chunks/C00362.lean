import S13Kernel.Data.Keys

/-! Keys number 27166 to 27255. `data/c/c00362.txt` has sha256 70f17ad25f9052f65c3dd14d171674e9695484a042c38ef2004f2af86d52e1dd. -/

namespace S13K.Chunks.C00362

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00362.txt"

theorem chk : chkChunk S N 27166 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 27166 27256 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00362
