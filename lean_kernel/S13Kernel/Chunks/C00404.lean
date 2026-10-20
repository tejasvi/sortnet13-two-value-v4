import S13Kernel.Data.Keys

/-! Keys number 31078 to 31169. `data/c/c00404.txt` has sha256 dc2650211496c70e4cf236551cc8b738ca3929c8adf9408261cda9fc36f4a067. -/

namespace S13K.Chunks.C00404

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00404.txt"

theorem chk : chkChunk S N 31078 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 31078 31170 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00404
