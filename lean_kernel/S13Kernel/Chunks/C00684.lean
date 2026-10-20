import S13Kernel.Data.Keys

/-! Keys number 56424 to 56507. `data/c/c00684.txt` has sha256 318a86119bc7a20c60bc9bd950e34ba18dd38b792a33b49dbc71240205c2bd99. -/

namespace S13K.Chunks.C00684

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00684.txt"

theorem chk : chkChunk S N 56424 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 56424 56508 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00684
