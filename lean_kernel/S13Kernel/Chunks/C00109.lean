import S13Kernel.Data.Keys

/-! Keys number 6643 to 6730. `data/c/c00109.txt` has sha256 2df985ee910f85a2ad311790a4ab9a38f76824d08111ce5c6aa7b9d66cb7bc72. -/

namespace S13K.Chunks.C00109

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00109.txt"

theorem chk : chkChunk S N 6643 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 6643 6731 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00109
