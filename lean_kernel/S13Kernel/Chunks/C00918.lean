import S13Kernel.Data.Keys

/-! Keys number 79519 to 79621. `data/c/c00918.txt` has sha256 03e2d0c1cee5794fa41a5dc5158fd5aef06c02472aec9372acc08827e643a93a. -/

namespace S13K.Chunks.C00918

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00918.txt"

theorem chk : chkChunk S N 79519 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 79519 79622 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00918
