import S13Kernel.Data.Keys

/-! Keys number 69735 to 69835. `data/c/c00821.txt` has sha256 6ec81bf659db42b09c0514c189b1ac93987c2f77af1dc2bb439d658d9236e567. -/

namespace S13K.Chunks.C00821

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00821.txt"

theorem chk : chkChunk S N 69735 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 69735 69836 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00821
