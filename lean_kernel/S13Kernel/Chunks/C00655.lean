import S13Kernel.Data.Keys

/-! Keys number 53720 to 53800. `data/c/c00655.txt` has sha256 6630cf860cddcfb333b1d77b56573eed3983d9765d4953067b7bc50e2846a910. -/

namespace S13K.Chunks.C00655

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00655.txt"

theorem chk : chkChunk S N 53720 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 53720 53801 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00655
