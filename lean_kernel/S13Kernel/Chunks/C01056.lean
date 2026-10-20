import S13Kernel.Data.Keys

/-! Keys number 94267 to 94383. `data/c/c01056.txt` has sha256 0f2170d97997cb7986912ff055aa7b95007b48971524c8bd7eab7b489b004280. -/

namespace S13K.Chunks.C01056

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01056.txt"

theorem chk : chkChunk S N 94267 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 94267 94384 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01056
