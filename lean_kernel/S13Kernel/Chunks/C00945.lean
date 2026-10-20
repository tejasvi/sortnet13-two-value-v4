import S13Kernel.Data.Keys

/-! Keys number 82235 to 82340. `data/c/c00945.txt` has sha256 07473ece0db83d6b205279da76e0e44e0f267c9930e7e6b0846286e741c9f6b1. -/

namespace S13K.Chunks.C00945

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00945.txt"

theorem chk : chkChunk S N 82235 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 82235 82341 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00945
