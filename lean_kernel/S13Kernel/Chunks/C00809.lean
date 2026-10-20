import S13Kernel.Data.Keys

/-! Keys number 68488 to 68580. `data/c/c00809.txt` has sha256 7a003a4d2b871b6b7d3f300aad98bea752976c1ac18fff23ecb6ae56b4cf5257. -/

namespace S13K.Chunks.C00809

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00809.txt"

theorem chk : chkChunk S N 68488 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 68488 68581 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00809
