import S13Kernel.Data.Keys

/-! Keys number 68992 to 69083. `data/c/c00814.txt` has sha256 f31e6fce329cd01bba137eb0e46008e23b9272467362fe553ce8ef705f813d7c. -/

namespace S13K.Chunks.C00814

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00814.txt"

theorem chk : chkChunk S N 68992 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 68992 69084 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00814
