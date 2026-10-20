import S13Kernel.Data.Keys

/-! Keys number 7746 to 7814. `data/c/c00124.txt` has sha256 0c512402ce3ae71b5f4cc7ea095b171ab5429ef228de5fdd781620fb2e926f04. -/

namespace S13K.Chunks.C00124

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00124.txt"

theorem chk : chkChunk S N 7746 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 7746 7815 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00124
