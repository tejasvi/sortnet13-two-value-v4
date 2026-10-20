import S13Kernel.Data.Keys

/-! Keys number 53256 to 53342. `data/c/c00650.txt` has sha256 5c59f70ba343f1cf61bf495b976dac504da5f208e2f19c152597b5d72d9ba5cf. -/

namespace S13K.Chunks.C00650

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00650.txt"

theorem chk : chkChunk S N 53256 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 53256 53343 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00650
