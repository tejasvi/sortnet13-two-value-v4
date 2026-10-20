import S13Kernel.Data.Keys

/-! Keys number 40839 to 40920. `data/c/c00516.txt` has sha256 a96527351c377695d0583856ab91ab53f88e420de0f74aee23975ee9dceb3ad0. -/

namespace S13K.Chunks.C00516

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00516.txt"

theorem chk : chkChunk S N 40839 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 40839 40921 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00516
