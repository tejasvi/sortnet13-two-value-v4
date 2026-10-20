import S13Kernel.Data.Keys

/-! Keys number 53153 to 53255. `data/c/c00649.txt` has sha256 06967cfbbb11d4ccc69ca2f01fb19e61c90def204a9c830a606d871683f3bc45. -/

namespace S13K.Chunks.C00649

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00649.txt"

theorem chk : chkChunk S N 53153 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 53153 53256 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00649
