import S13Kernel.Data.Keys

/-! Keys number 47237 to 47321. `data/c/c00583.txt` has sha256 f86afb3e66a0eb876fb5e956ca27b4f8a85f4357a695b0a505482f330b48ed01. -/

namespace S13K.Chunks.C00583

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00583.txt"

theorem chk : chkChunk S N 47237 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 47237 47322 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00583
