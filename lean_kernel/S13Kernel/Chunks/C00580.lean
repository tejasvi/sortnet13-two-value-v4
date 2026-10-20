import S13Kernel.Data.Keys

/-! Keys number 46932 to 47033. `data/c/c00580.txt` has sha256 accece6ebcd9a8ff576db31d2d3cea890e864e7f3975963fa37460a858d8f8ed. -/

namespace S13K.Chunks.C00580

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00580.txt"

theorem chk : chkChunk S N 46932 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 46932 47034 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00580
