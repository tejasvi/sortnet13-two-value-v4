import S13Kernel.Data.Keys

/-! Keys number 26568 to 26663. `data/c/c00355.txt` has sha256 3c954af00ef90d18db4f711d22c2b786bb24d5a9b1539a94251422977db73028. -/

namespace S13K.Chunks.C00355

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00355.txt"

theorem chk : chkChunk S N 26568 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 26568 26664 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00355
