import S13Kernel.Data.Keys

/-! Keys number 89046 to 89152. `data/c/c01009.txt` has sha256 191bf230536c063fc267f237d37103e319bb5eaa0c0759598b6053d4820fdcf6. -/

namespace S13K.Chunks.C01009

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01009.txt"

theorem chk : chkChunk S N 89046 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 89046 89153 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01009
