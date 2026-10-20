import S13Kernel.Data.Keys

/-! Keys number 42987 to 43095. `data/c/c00539.txt` has sha256 25f4cf2306b8b4f3c165046736b1ed5d1ad47df7c699ea58c67d29867604b0be. -/

namespace S13K.Chunks.C00539

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00539.txt"

theorem chk : chkChunk S N 42987 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 42987 43096 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00539
