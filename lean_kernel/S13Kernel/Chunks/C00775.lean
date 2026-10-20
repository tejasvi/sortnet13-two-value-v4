import S13Kernel.Data.Keys

/-! Keys number 65366 to 65454. `data/c/c00775.txt` has sha256 6ebbdceae1b1facda342efee1c52f70b08797cf2c621de068518db283d045aae. -/

namespace S13K.Chunks.C00775

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00775.txt"

theorem chk : chkChunk S N 65366 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 65366 65455 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00775
