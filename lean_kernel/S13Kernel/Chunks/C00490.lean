import S13Kernel.Data.Keys

/-! Keys number 38605 to 38690. `data/c/c00490.txt` has sha256 cb805066614bb933c045b0c51ca22b0d89979cfc2517fc69857657ce7b43486d. -/

namespace S13K.Chunks.C00490

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00490.txt"

theorem chk : chkChunk S N 38605 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 38605 38691 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00490
