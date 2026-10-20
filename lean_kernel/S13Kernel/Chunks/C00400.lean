import S13Kernel.Data.Keys

/-! Keys number 30759 to 30836. `data/c/c00400.txt` has sha256 b67465a88b2454940e3dca964b775e130cca51b6e2e3b1e5a74627cf68fa5094. -/

namespace S13K.Chunks.C00400

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00400.txt"

theorem chk : chkChunk S N 30759 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 30759 30837 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00400
