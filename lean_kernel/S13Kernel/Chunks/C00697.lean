import S13Kernel.Data.Keys

/-! Keys number 57600 to 57693. `data/c/c00697.txt` has sha256 b061c02df9ca517fd80701347551c32cc4770119e5c5f80f936bd8fdaf44f08b. -/

namespace S13K.Chunks.C00697

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00697.txt"

theorem chk : chkChunk S N 57600 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 57600 57694 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00697
