import S13Kernel.Data.Keys

/-! Keys number 11987 to 12064. `data/c/c00181.txt` has sha256 4eb2e0cd90150a0ef6c7d8f69909946494dbdf9657473cb4b8f1944b34b7e3ba. -/

namespace S13K.Chunks.C00181

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00181.txt"

theorem chk : chkChunk S N 11987 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 11987 12065 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00181
