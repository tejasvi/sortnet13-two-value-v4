import S13Kernel.Data.Keys

/-! Keys number 36746 to 36839. `data/c/c00471.txt` has sha256 c009384fa57b4b7d443edd5340969cc28c909f3366baff7ba26fa2e83b505281. -/

namespace S13K.Chunks.C00471

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00471.txt"

theorem chk : chkChunk S N 36746 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 36746 36840 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00471
