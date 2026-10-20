import S13Kernel.Data.Keys

/-! Keys number 54923 to 55015. `data/c/c00667.txt` has sha256 6be03a461614b63c9c529e39c325cd691f5bb70235eba6f01df1182438c34644. -/

namespace S13K.Chunks.C00667

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00667.txt"

theorem chk : chkChunk S N 54923 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 54923 55016 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00667
