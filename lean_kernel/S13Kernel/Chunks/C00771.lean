import S13Kernel.Data.Keys

/-! Keys number 65005 to 65108. `data/c/c00771.txt` has sha256 98e94551780c47a28ce8f2692deb31befb88186f85fa3b386a625e8666607af5. -/

namespace S13K.Chunks.C00771

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00771.txt"

theorem chk : chkChunk S N 65005 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 65005 65109 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00771
