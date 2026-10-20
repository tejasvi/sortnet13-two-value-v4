import S13Kernel.Data.Keys

/-! Keys number 59798 to 59904. `data/c/c00719.txt` has sha256 307d0d8db28254d43745036121605d1610b4302d539f0a5957e3fecdcfdf5341. -/

namespace S13K.Chunks.C00719

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00719.txt"

theorem chk : chkChunk S N 59798 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 59798 59905 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00719
