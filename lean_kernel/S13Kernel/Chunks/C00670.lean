import S13Kernel.Data.Keys

/-! Keys number 55208 to 55294. `data/c/c00670.txt` has sha256 8ede02e8a9c29b6708ab1904b2606237b17185058ebe7cf35bd880122939a27c. -/

namespace S13K.Chunks.C00670

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00670.txt"

theorem chk : chkChunk S N 55208 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 55208 55295 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00670
