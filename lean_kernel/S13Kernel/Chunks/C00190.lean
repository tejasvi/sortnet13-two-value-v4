import S13Kernel.Data.Keys

/-! Keys number 12705 to 12791. `data/c/c00190.txt` has sha256 ef88f9c8476ad6154e0d847c29c9ff24ed693b143865f09e83e26cf163c147dc. -/

namespace S13K.Chunks.C00190

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00190.txt"

theorem chk : chkChunk S N 12705 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 12705 12792 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00190
