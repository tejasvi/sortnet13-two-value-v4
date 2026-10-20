import S13Kernel.Data.Keys

/-! Keys number 59254 to 59359. `data/c/c00714.txt` has sha256 f187e9e7b4b8626784ef6ac932970a74e11cd3f96823b8cbdb2ff2939d97c4d4. -/

namespace S13K.Chunks.C00714

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00714.txt"

theorem chk : chkChunk S N 59254 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 59254 59360 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00714
