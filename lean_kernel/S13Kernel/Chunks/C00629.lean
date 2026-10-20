import S13Kernel.Data.Keys

/-! Keys number 51254 to 51346. `data/c/c00629.txt` has sha256 7aa2f7af06c534c9a6d0a66144db3ee53fd81cea20e4e9ac41f78730e581c4ca. -/

namespace S13K.Chunks.C00629

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00629.txt"

theorem chk : chkChunk S N 51254 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 51254 51347 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00629
