import S13Kernel.Data.Keys

/-! Keys number 25919 to 26012. `data/c/c00348.txt` has sha256 e9f819447f158227bf1bea027585ef3355b74d86f031eb541bce24bfeab85b2b. -/

namespace S13K.Chunks.C00348

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00348.txt"

theorem chk : chkChunk S N 25919 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 25919 26013 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00348
