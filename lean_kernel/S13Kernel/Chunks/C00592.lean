import S13Kernel.Data.Keys

/-! Keys number 48062 to 48159. `data/c/c00592.txt` has sha256 93f0cee9381283cc7e20c351bfe5e47ba7f188f40d30c942c607bdf1a6c354c3. -/

namespace S13K.Chunks.C00592

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00592.txt"

theorem chk : chkChunk S N 48062 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 48062 48160 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00592
