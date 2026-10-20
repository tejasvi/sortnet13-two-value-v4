import S13Kernel.Data.Keys

/-! Keys number 88821 to 88932. `data/c/c01007.txt` has sha256 d9de1557336e4019e75893d70d917482f4ab7dd00fb38858b2a5838d341dcd82. -/

namespace S13K.Chunks.C01007

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01007.txt"

theorem chk : chkChunk S N 88821 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 88821 88933 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01007
