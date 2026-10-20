import S13Kernel.Data.Keys

/-! Keys number 59905 to 60013. `data/c/c00720.txt` has sha256 1ec73f1081a98d445ca26d5bac5f4693209eab51f81b47697ab2532376f65eda. -/

namespace S13K.Chunks.C00720

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00720.txt"

theorem chk : chkChunk S N 59905 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 59905 60014 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00720
