import S13Kernel.Data.Keys

/-! Keys number 84793 to 84900. `data/c/c00969.txt` has sha256 11b77fc659f5e879b5ec52284950b9d7ea11168221cada88b870bd1ac02ead04. -/

namespace S13K.Chunks.C00969

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00969.txt"

theorem chk : chkChunk S N 84793 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 84793 84901 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00969
