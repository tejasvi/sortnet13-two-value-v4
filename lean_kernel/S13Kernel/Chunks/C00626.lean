import S13Kernel.Data.Keys

/-! Keys number 50976 to 51071. `data/c/c00626.txt` has sha256 a6f2100b922dd37dcfa20066c4f0599d2a77b268c9c68367adddd24e59795758. -/

namespace S13K.Chunks.C00626

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00626.txt"

theorem chk : chkChunk S N 50976 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 50976 51072 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00626
