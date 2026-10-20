import S13Kernel.Data.Keys

/-! Keys number 51347 to 51429. `data/c/c00630.txt` has sha256 20fd199bbe5311b4518d338e6d34583fe92d978249ca8af0d4aad2e17d19000c. -/

namespace S13K.Chunks.C00630

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00630.txt"

theorem chk : chkChunk S N 51347 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 51347 51430 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00630
