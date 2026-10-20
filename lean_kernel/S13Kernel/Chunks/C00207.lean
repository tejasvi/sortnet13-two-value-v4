import S13Kernel.Data.Keys

/-! Keys number 14176 to 14253. `data/c/c00207.txt` has sha256 fd8d620634257b69e92711c468fd20f4fbb22cf347292a1ed9523c3de2fd3ba1. -/

namespace S13K.Chunks.C00207

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00207.txt"

theorem chk : chkChunk S N 14176 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 14176 14254 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00207
