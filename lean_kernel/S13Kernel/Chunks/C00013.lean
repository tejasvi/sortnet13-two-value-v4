import S13Kernel.Data.Keys

/-! Keys number 568 to 613. `data/c/c00013.txt` has sha256 48f1d2fcab30f7f60154212d74c0920d23a89898488baa6954e56c342cc05e9e. -/

namespace S13K.Chunks.C00013

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00013.txt"

theorem chk : chkChunk S N 568 46 ces = true := by decide +kernel

theorem ok : RangeOK S N 568 614 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00013
