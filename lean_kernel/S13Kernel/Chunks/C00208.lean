import S13Kernel.Data.Keys

/-! Keys number 14254 to 14323. `data/c/c00208.txt` has sha256 07f2d3bb9376d46dd8cbc0006c7451263dfe9170c6b86dbd4a26b45bd37e40d3. -/

namespace S13K.Chunks.C00208

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00208.txt"

theorem chk : chkChunk S N 14254 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 14254 14324 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00208
