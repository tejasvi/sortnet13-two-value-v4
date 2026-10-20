import S13Kernel.Data.Keys

/-! Keys number 16330 to 16397. `data/c/c00233.txt` has sha256 968737c3a47d8d1620b0401295062dff333cb062a2355b721ccd97e29d0f10e3. -/

namespace S13K.Chunks.C00233

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00233.txt"

theorem chk : chkChunk S N 16330 68 ces = true := by decide +kernel

theorem ok : RangeOK S N 16330 16398 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00233
