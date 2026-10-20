import S13Kernel.Data.Keys

/-! Keys number 78689 to 78787. `data/c/c00910.txt` has sha256 bd955cf922a58da71908d426730be6ec71db28c3114d801710c3d2ba58ff0fad. -/

namespace S13K.Chunks.C00910

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00910.txt"

theorem chk : chkChunk S N 78689 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 78689 78788 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00910
