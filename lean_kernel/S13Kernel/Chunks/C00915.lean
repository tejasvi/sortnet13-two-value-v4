import S13Kernel.Data.Keys

/-! Keys number 79228 to 79328. `data/c/c00915.txt` has sha256 e42d380328b657a9244737ef4a4ce863940aae3530ec3742522f451a70762301. -/

namespace S13K.Chunks.C00915

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00915.txt"

theorem chk : chkChunk S N 79228 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 79228 79329 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00915
