import S13Kernel.Data.Keys

/-! Keys number 59360 to 59467. `data/c/c00715.txt` has sha256 64bf69ce363224b2fe4fc5b1bec8c0cc2859f8835e3f7b18e1c3f15ff973a8aa. -/

namespace S13K.Chunks.C00715

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00715.txt"

theorem chk : chkChunk S N 59360 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 59360 59468 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00715
