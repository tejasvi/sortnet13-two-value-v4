import S13Kernel.Data.Keys

/-! Keys number 52645 to 52744. `data/c/c00644.txt` has sha256 00f385c414eb6fb07fdd963053cee61be1282a57cf5ebc33118937ec16499442. -/

namespace S13K.Chunks.C00644

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00644.txt"

theorem chk : chkChunk S N 52645 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 52645 52745 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00644
