import S13Kernel.Data.Keys

/-! Keys number 66705 to 66801. `data/c/c00790.txt` has sha256 04a861070fbb2ff472c7aa2094156c3ba26f9f35bc98badf447badcaced19df4. -/

namespace S13K.Chunks.C00790

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00790.txt"

theorem chk : chkChunk S N 66705 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 66705 66802 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00790
