import S13Kernel.Data.Keys

/-! Keys number 3619 to 3694. `data/c/c00065.txt` has sha256 63c3688a9912a1fa74efaa9c2530c2917ec6a5ca884373fe1435673ceac8ccbb. -/

namespace S13K.Chunks.C00065

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00065.txt"

theorem chk : chkChunk S N 3619 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 3619 3695 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00065
