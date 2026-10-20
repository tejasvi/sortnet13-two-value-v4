import S13Kernel.Data.Keys

/-! Keys number 57131 to 57213. `data/c/c00692.txt` has sha256 1b488bd80132bbe2cd1560a6694626481e68bd90a374ac7870d539c5c62cfcc4. -/

namespace S13K.Chunks.C00692

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00692.txt"

theorem chk : chkChunk S N 57131 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 57131 57214 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00692
