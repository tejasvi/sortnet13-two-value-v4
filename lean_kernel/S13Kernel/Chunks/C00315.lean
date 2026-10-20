import S13Kernel.Data.Keys

/-! Keys number 22976 to 23066. `data/c/c00315.txt` has sha256 f62de7d9fc287401665f0abcfc0af219288412b77369d4b9cdd9f1b5072ea237. -/

namespace S13K.Chunks.C00315

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00315.txt"

theorem chk : chkChunk S N 22976 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 22976 23067 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00315
