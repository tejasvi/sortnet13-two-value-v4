import S13Kernel.Data.Keys

/-! Keys number 33926 to 34012. `data/c/c00438.txt` has sha256 7e02edf48aa6373bdc44a18134da71beffe997cd4e532ea8f18390b6924efa45. -/

namespace S13K.Chunks.C00438

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00438.txt"

theorem chk : chkChunk S N 33926 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 33926 34013 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00438
