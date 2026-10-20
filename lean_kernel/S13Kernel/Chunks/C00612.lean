import S13Kernel.Data.Keys

/-! Keys number 49790 to 49873. `data/c/c00612.txt` has sha256 d799e33dd083c25db0c3d367e0984778ed03d70cfbef0437b6f9d41a56a5acc4. -/

namespace S13K.Chunks.C00612

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00612.txt"

theorem chk : chkChunk S N 49790 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 49790 49874 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00612
