import S13Kernel.Data.Keys

/-! Keys number 6968 to 7050. `data/c/c00113.txt` has sha256 db1e8bfc7391afefdc094a0cc69d3231b16a801fa2c87407d5b438ccd8eb4756. -/

namespace S13K.Chunks.C00113

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00113.txt"

theorem chk : chkChunk S N 6968 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 6968 7051 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00113
