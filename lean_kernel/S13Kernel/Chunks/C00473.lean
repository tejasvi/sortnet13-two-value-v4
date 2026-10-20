import S13Kernel.Data.Keys

/-! Keys number 36916 to 36988. `data/c/c00473.txt` has sha256 7624c978424285639bcbcc97eb20537b16a4d43a436b6a30da03949fd947d70a. -/

namespace S13K.Chunks.C00473

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00473.txt"

theorem chk : chkChunk S N 36916 73 ces = true := by decide +kernel

theorem ok : RangeOK S N 36916 36989 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00473
