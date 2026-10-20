import S13Kernel.Data.Keys

/-! Keys number 72200 to 72284. `data/c/c00846.txt` has sha256 9f3fbce27291430806f987ea7725740d52ab6c1340dcd322b1feda45616ebd2a. -/

namespace S13K.Chunks.C00846

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00846.txt"

theorem chk : chkChunk S N 72200 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 72200 72285 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00846
