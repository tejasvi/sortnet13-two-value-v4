import S13Kernel.Data.Keys

/-! Keys number 44019 to 44131. `data/c/c00549.txt` has sha256 8fb57826112580e8ade9d94bebd46c0b30af49c1c4cc013cedd27eea249d84a0. -/

namespace S13K.Chunks.C00549

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00549.txt"

theorem chk : chkChunk S N 44019 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 44019 44132 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00549
