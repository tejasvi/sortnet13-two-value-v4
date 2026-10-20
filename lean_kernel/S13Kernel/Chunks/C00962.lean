import S13Kernel.Data.Keys

/-! Keys number 84056 to 84171. `data/c/c00962.txt` has sha256 3517590697a6ada40c7ae5c1384b8c8ac8a6f61129acfc16ca9d2a464f5da178. -/

namespace S13K.Chunks.C00962

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00962.txt"

theorem chk : chkChunk S N 84056 116 ces = true := by decide +kernel

theorem ok : RangeOK S N 84056 84172 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00962
