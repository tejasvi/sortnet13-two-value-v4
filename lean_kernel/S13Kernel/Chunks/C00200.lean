import S13Kernel.Data.Keys

/-! Keys number 13614 to 13687. `data/c/c00200.txt` has sha256 4430379f94d22fb4118caee67491b54ce316542d41b8fc3a171003e8a6912ebd. -/

namespace S13K.Chunks.C00200

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00200.txt"

theorem chk : chkChunk S N 13614 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 13614 13688 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00200
