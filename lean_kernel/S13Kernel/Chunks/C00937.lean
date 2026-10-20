import S13Kernel.Data.Keys

/-! Keys number 81417 to 81517. `data/c/c00937.txt` has sha256 6217608804c69d549a2c189eaae8a4c5ee39cf858f1de68b66035abf9f514ff6. -/

namespace S13K.Chunks.C00937

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00937.txt"

theorem chk : chkChunk S N 81417 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 81417 81518 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00937
