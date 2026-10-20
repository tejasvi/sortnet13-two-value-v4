import S13Kernel.Data.Keys

/-! Keys number 18757 to 18849. `data/c/c00261.txt` has sha256 17ec80f3ec282e3dd720beb50cf5920bd12a9cfe6a1ea3a05eeb091644284c2a. -/

namespace S13K.Chunks.C00261

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00261.txt"

theorem chk : chkChunk S N 18757 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 18757 18850 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00261
