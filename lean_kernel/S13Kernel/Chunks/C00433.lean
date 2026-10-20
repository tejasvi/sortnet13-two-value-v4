import S13Kernel.Data.Keys

/-! Keys number 33544 to 33615. `data/c/c00433.txt` has sha256 e63532deae0ac775bff5b3177f7412b8e603e91959e7074423ef1a939df2355c. -/

namespace S13K.Chunks.C00433

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00433.txt"

theorem chk : chkChunk S N 33544 72 ces = true := by decide +kernel

theorem ok : RangeOK S N 33544 33616 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00433
