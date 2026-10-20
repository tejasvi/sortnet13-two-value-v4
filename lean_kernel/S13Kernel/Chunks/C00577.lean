import S13Kernel.Data.Keys

/-! Keys number 46643 to 46733. `data/c/c00577.txt` has sha256 cfacc1eeb8fd9a3294227d766b1bf4d50e177cb46d65795622a3941e37ccc2f3. -/

namespace S13K.Chunks.C00577

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00577.txt"

theorem chk : chkChunk S N 46643 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 46643 46734 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00577
