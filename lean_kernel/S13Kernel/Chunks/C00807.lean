import S13Kernel.Data.Keys

/-! Keys number 68286 to 68388. `data/c/c00807.txt` has sha256 d56cc97857c942280253b37dbea04936650e3fd5b2f266ba6816469c9f7c24a1. -/

namespace S13K.Chunks.C00807

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00807.txt"

theorem chk : chkChunk S N 68286 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 68286 68389 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00807
