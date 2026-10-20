import S13Kernel.Data.Keys

/-! Keys number 29652 to 29731. `data/c/c00388.txt` has sha256 05f1c067d027fe5a5f4419b0970fc269c89de867b39896ae0dd1120f87f092ac. -/

namespace S13K.Chunks.C00388

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00388.txt"

theorem chk : chkChunk S N 29652 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 29652 29732 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00388
