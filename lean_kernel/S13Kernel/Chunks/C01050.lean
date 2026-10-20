import S13Kernel.Data.Keys

/-! Keys number 93594 to 93710. `data/c/c01050.txt` has sha256 da28f6aab8dbf57a8f362bd696f7b90d72e8a6f0d91b0b431c35b90c00877b98. -/

namespace S13K.Chunks.C01050

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01050.txt"

theorem chk : chkChunk S N 93594 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 93594 93711 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01050
