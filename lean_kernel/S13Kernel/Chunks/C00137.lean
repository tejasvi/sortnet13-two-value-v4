import S13Kernel.Data.Keys

/-! Keys number 8780 to 8843. `data/c/c00137.txt` has sha256 e610ae9a4be47a3df3b0aa176185b8d2c2550086105ad8f27f70d41d334f3dab. -/

namespace S13K.Chunks.C00137

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00137.txt"

theorem chk : chkChunk S N 8780 64 ces = true := by decide +kernel

theorem ok : RangeOK S N 8780 8844 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00137
