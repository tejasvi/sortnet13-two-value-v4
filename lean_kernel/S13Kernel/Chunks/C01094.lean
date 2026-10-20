import S13Kernel.Data.Keys

/-! Keys number 98729 to 98849. `data/c/c01094.txt` has sha256 edafbb4a3b603b13fb9cda2bfd72c36c5250cd863170e6aea12f5d5989510b92. -/

namespace S13K.Chunks.C01094

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01094.txt"

theorem chk : chkChunk S N 98729 121 ces = true := by decide +kernel

theorem ok : RangeOK S N 98729 98850 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01094
