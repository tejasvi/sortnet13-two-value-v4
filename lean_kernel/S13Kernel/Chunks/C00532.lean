import S13Kernel.Data.Keys

/-! Keys number 42328 to 42413. `data/c/c00532.txt` has sha256 52dd4fcb006d92793310d098294b0c4e7b72f1601e18e9c09cba9015ef253458. -/

namespace S13K.Chunks.C00532

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00532.txt"

theorem chk : chkChunk S N 42328 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 42328 42414 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00532
