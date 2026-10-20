import S13Kernel.Data.Keys

/-! Keys number 39962 to 40059. `data/c/c00506.txt` has sha256 21c07e7be9c9e7c29bcbe452c5dcf65c7d74d6cc92a898c88f9e90c9dae56938. -/

namespace S13K.Chunks.C00506

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00506.txt"

theorem chk : chkChunk S N 39962 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 39962 40060 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00506
