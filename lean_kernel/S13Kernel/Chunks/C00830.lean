import S13Kernel.Data.Keys

/-! Keys number 70620 to 70718. `data/c/c00830.txt` has sha256 dbc0ab3dd2d26772d3be8ff43c3d6b91161b5a7c5e4ceba5a10a00935df7dc62. -/

namespace S13K.Chunks.C00830

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00830.txt"

theorem chk : chkChunk S N 70620 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 70620 70719 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00830
