import S13Kernel.Data.Keys

/-! Keys number 9978 to 10060. `data/c/c00152.txt` has sha256 74f3dbdc0d214e6cf19b393b3ba57fd0201fb65e3f68ac6edecfb15bc44f7d3f. -/

namespace S13K.Chunks.C00152

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00152.txt"

theorem chk : chkChunk S N 9978 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 9978 10061 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00152
