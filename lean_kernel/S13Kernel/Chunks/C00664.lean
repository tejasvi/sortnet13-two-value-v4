import S13Kernel.Data.Keys

/-! Keys number 54572 to 54696. `data/c/c00664.txt` has sha256 1ef20ed1f18c721d548d19323688f261a8d3646325103b74a4bcfd57571758f9. -/

namespace S13K.Chunks.C00664

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00664.txt"

theorem chk : chkChunk S N 54572 125 ces = true := by decide +kernel

theorem ok : RangeOK S N 54572 54697 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00664
