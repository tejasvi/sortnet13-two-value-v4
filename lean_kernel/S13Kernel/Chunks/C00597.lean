import S13Kernel.Data.Keys

/-! Keys number 48557 to 48633. `data/c/c00597.txt` has sha256 e412f73493c4f54c7f52c535ce3c880f4f2b37bcd5d68fe875f9eab5fecfae1f. -/

namespace S13K.Chunks.C00597

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00597.txt"

theorem chk : chkChunk S N 48557 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 48557 48634 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00597
