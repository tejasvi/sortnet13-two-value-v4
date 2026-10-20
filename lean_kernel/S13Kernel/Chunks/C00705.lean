import S13Kernel.Data.Keys

/-! Keys number 58332 to 58424. `data/c/c00705.txt` has sha256 bd1d89795705eb6a12db77b5f2c4f5bb7828ec595175d1305937169114e46d84. -/

namespace S13K.Chunks.C00705

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00705.txt"

theorem chk : chkChunk S N 58332 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 58332 58425 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00705
