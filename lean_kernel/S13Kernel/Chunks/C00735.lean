import S13Kernel.Data.Keys

/-! Keys number 61427 to 61518. `data/c/c00735.txt` has sha256 8b7fc0d0328802f3ee95ec360846603a262a5c7727e8f7faa912703ca4907ff5. -/

namespace S13K.Chunks.C00735

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00735.txt"

theorem chk : chkChunk S N 61427 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 61427 61519 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00735
