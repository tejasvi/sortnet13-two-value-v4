import S13Kernel.Data.Keys

/-! Keys number 55907 to 55994. `data/c/c00678.txt` has sha256 cdaab3d3dcda0c885d6fa17ccdd7c09088db5184546398159d53bc5c5e6b8db8. -/

namespace S13K.Chunks.C00678

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00678.txt"

theorem chk : chkChunk S N 55907 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 55907 55995 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00678
