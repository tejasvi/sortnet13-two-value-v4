import S13Kernel.Data.Keys

/-! Keys number 33856 to 33925. `data/c/c00437.txt` has sha256 1bf95396be560aa5ca3d4ab55d29ceeaee980567a91f86458facaf5155400b03. -/

namespace S13K.Chunks.C00437

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00437.txt"

theorem chk : chkChunk S N 33856 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 33856 33926 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00437
