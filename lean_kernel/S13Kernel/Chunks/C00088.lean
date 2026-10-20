import S13Kernel.Data.Keys

/-! Keys number 5251 to 5303. `data/c/c00088.txt` has sha256 0b5597407bf5b8ab9abb620ff5eec7c95f4e97cc9f2519c84ad2f6d99b0d1e9f. -/

namespace S13K.Chunks.C00088

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00088.txt"

theorem chk : chkChunk S N 5251 53 ces = true := by decide +kernel

theorem ok : RangeOK S N 5251 5304 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00088
