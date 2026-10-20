import S13Kernel.Data.Keys

/-! Keys number 95050 to 95158. `data/c/c01063.txt` has sha256 142e594685a6ce2a5d35585ed41be88ccca664dfb0026b4450c0223e4d53b162. -/

namespace S13K.Chunks.C01063

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01063.txt"

theorem chk : chkChunk S N 95050 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 95050 95159 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01063
