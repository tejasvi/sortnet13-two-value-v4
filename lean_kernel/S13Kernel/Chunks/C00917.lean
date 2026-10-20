import S13Kernel.Data.Keys

/-! Keys number 79420 to 79518. `data/c/c00917.txt` has sha256 98dcfd9aef0df76b86ee8f7b4b21ff66bf11effb55949836d2b681745cd31fe6. -/

namespace S13K.Chunks.C00917

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00917.txt"

theorem chk : chkChunk S N 79420 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 79420 79519 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00917
