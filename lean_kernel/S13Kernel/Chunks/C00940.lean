import S13Kernel.Data.Keys

/-! Keys number 81717 to 81822. `data/c/c00940.txt` has sha256 92396c79912090424d0b7adb0be63a69a02c8c8d3cc3412bcab0849c61a7e848. -/

namespace S13K.Chunks.C00940

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00940.txt"

theorem chk : chkChunk S N 81717 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 81717 81823 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00940
