import S13Kernel.Data.Keys

/-! Keys number 44433 to 44529. `data/c/c00553.txt` has sha256 043d68096d9e25fe3a45e4b207f276707c9022b4748feb39bed4ea9cd55cb8cf. -/

namespace S13K.Chunks.C00553

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00553.txt"

theorem chk : chkChunk S N 44433 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 44433 44530 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00553
