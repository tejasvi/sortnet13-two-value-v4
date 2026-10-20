import S13Kernel.Data.Keys

/-! Keys number 89485 to 89598. `data/c/c01013.txt` has sha256 7d86eb3cea59e1abb2d9affd00e69e3ebb41bf59bd06326796e509ee5f2138bd. -/

namespace S13K.Chunks.C01013

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01013.txt"

theorem chk : chkChunk S N 89485 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 89485 89599 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01013
