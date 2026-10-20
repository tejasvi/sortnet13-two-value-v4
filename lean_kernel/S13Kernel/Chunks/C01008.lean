import S13Kernel.Data.Keys

/-! Keys number 88933 to 89045. `data/c/c01008.txt` has sha256 451d6e38cb07cb2fe1180757154388bf9638c1abb4b34eef557b950aacc13648. -/

namespace S13K.Chunks.C01008

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01008.txt"

theorem chk : chkChunk S N 88933 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 88933 89046 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01008
