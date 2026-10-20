import S13Kernel.Data.Keys

/-! Keys number 11248 to 11294. `data/c/c00170.txt` has sha256 74be3904a8b01b3bf70c52c8e277592871c1bc0de53739b1a5de6065d03642a1. -/

namespace S13K.Chunks.C00170

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00170.txt"

theorem chk : chkChunk S N 11248 47 ces = true := by decide +kernel

theorem ok : RangeOK S N 11248 11295 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00170
