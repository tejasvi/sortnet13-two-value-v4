import S13Kernel.Data.Keys

/-! Keys number 56956 to 57038. `data/c/c00690.txt` has sha256 37f60e181a473f192d55d00d29d67c047f9b41c5a20029c2a40ee0a9ef5f4239. -/

namespace S13K.Chunks.C00690

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00690.txt"

theorem chk : chkChunk S N 56956 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 56956 57039 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00690
