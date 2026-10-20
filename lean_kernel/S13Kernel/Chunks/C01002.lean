import S13Kernel.Data.Keys

/-! Keys number 88234 to 88357. `data/c/c01002.txt` has sha256 01cf15a929aa67545027ccc392a924cf450a9179d5cebee4d5f33454d365f1e6. -/

namespace S13K.Chunks.C01002

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01002.txt"

theorem chk : chkChunk S N 88234 124 ces = true := by decide +kernel

theorem ok : RangeOK S N 88234 88358 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01002
