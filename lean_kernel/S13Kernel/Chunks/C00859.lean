import S13Kernel.Data.Keys

/-! Keys number 73398 to 73483. `data/c/c00859.txt` has sha256 0c77b7ad8ecdb2c22a632b7dd4ec307460774fba5c628dae074c1c0b48073236. -/

namespace S13K.Chunks.C00859

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00859.txt"

theorem chk : chkChunk S N 73398 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 73398 73484 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00859
