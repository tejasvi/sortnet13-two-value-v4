import S13Kernel.Data.Keys

/-! Keys number 83145 to 83262. `data/c/c00954.txt` has sha256 fa0b7b9dbf445d2528ad106f15215d3438a6ee13fd0cd923b02b6d3d2fa47008. -/

namespace S13K.Chunks.C00954

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00954.txt"

theorem chk : chkChunk S N 83145 118 ces = true := by decide +kernel

theorem ok : RangeOK S N 83145 83263 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00954
