import S13Kernel.Data.Keys

/-! Keys number 15525 to 15615. `data/c/c00224.txt` has sha256 840c6f4a1d9564674d70be2bba4ed16a6da5f261d7945390788c8becac87e0d5. -/

namespace S13K.Chunks.C00224

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00224.txt"

theorem chk : chkChunk S N 15525 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 15525 15616 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00224
