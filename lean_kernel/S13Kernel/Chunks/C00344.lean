import S13Kernel.Data.Keys

/-! Keys number 25608 to 25701. `data/c/c00344.txt` has sha256 9ea4ca0b9a5fa4eb55338162f1fe58c1ec823a5b8e07fbfa3b89fd6572942023. -/

namespace S13K.Chunks.C00344

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00344.txt"

theorem chk : chkChunk S N 25608 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 25608 25702 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00344
