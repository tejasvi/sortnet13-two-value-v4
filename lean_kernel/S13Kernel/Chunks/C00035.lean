import S13Kernel.Data.Keys

/-! Keys number 1773 to 1829. `data/c/c00035.txt` has sha256 6f3efe46bfecc6ae0ba78023c9a90652ffd640d3b84c3c6cceaf16c5d4072571. -/

namespace S13K.Chunks.C00035

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00035.txt"

theorem chk : chkChunk S N 1773 57 ces = true := by decide +kernel

theorem ok : RangeOK S N 1773 1830 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00035
