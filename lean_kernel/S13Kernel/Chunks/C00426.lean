import S13Kernel.Data.Keys

/-! Keys number 33012 to 33081. `data/c/c00426.txt` has sha256 a51de2b1158a8a3886868c18695740d261054eddbbe822545b1cfabb4bf99917. -/

namespace S13K.Chunks.C00426

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00426.txt"

theorem chk : chkChunk S N 33012 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 33012 33082 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00426
