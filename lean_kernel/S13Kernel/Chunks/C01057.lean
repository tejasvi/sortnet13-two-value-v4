import S13Kernel.Data.Keys

/-! Keys number 94384 to 94491. `data/c/c01057.txt` has sha256 ecf8c501356b5f3d98548a7a774c4cc078808cf6a342abff836bb55e1e2709f0. -/

namespace S13K.Chunks.C01057

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01057.txt"

theorem chk : chkChunk S N 94384 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 94384 94492 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01057
