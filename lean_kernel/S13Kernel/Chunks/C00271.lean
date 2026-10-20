import S13Kernel.Data.Keys

/-! Keys number 19624 to 19713. `data/c/c00271.txt` has sha256 2a3f7618835dfec91190aa5a805282bf41e6238caa72efa1443b4407a77b1e96. -/

namespace S13K.Chunks.C00271

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00271.txt"

theorem chk : chkChunk S N 19624 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 19624 19714 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00271
