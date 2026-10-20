import S13Kernel.Data.Keys

/-! Keys number 86735 to 86845. `data/c/c00988.txt` has sha256 c0b43e28b4730bf52f8e921b7d9e931b8cacdaeab1ec29fe0ef30d6d936c1c56. -/

namespace S13K.Chunks.C00988

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00988.txt"

theorem chk : chkChunk S N 86735 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 86735 86846 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00988
