import S13Kernel.Data.Keys

/-! Keys number 97751 to 97876. `data/c/c01086.txt` has sha256 05adc9a19ea545407e7aa202675b14c1da7d7d3e19843628c4e5713823354c98. -/

namespace S13K.Chunks.C01086

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01086.txt"

theorem chk : chkChunk S N 97751 126 ces = true := by decide +kernel

theorem ok : RangeOK S N 97751 97877 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01086
