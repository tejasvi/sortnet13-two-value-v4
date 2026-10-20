import S13Kernel.Data.Keys

/-! Keys number 81230 to 81328. `data/c/c00935.txt` has sha256 801dcb76588846c578646f0aa3b98cb8c294fff93c2ffa0d366cb05cc9c05d57. -/

namespace S13K.Chunks.C00935

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00935.txt"

theorem chk : chkChunk S N 81230 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 81230 81329 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00935
