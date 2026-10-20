import S13Kernel.Data.Keys

/-! Keys number 79819 to 79928. `data/c/c00921.txt` has sha256 7c92506494e1b607c0812af5ccbd17b31a095ee9eb0358260b1c52eb6a949e5e. -/

namespace S13K.Chunks.C00921

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00921.txt"

theorem chk : chkChunk S N 79819 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 79819 79929 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00921
