import S13Kernel.Data.Keys

/-! Keys number 63291 to 63386. `data/c/c00754.txt` has sha256 1043ddea8b5e4200c3d698b95bb5afe474aea1a3f886e6b5481e74bcc713480f. -/

namespace S13K.Chunks.C00754

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00754.txt"

theorem chk : chkChunk S N 63291 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 63291 63387 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00754
