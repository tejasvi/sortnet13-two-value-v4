import S13Kernel.Data.Keys

/-! Keys number 95620 to 95729. `data/c/c01068.txt` has sha256 bdb8ba4eb82ca9cf6bab5ce4c4fd5641199c352ccdf8e7b15574166ab06c516b. -/

namespace S13K.Chunks.C01068

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01068.txt"

theorem chk : chkChunk S N 95620 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 95620 95730 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01068
