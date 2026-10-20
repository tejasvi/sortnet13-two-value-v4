import S13Kernel.Data.Keys

/-! Keys number 48954 to 49030. `data/c/c00602.txt` has sha256 01e786d87c82a2b87fd3ef0b038aebb57e19f0588315915c56e3089661f262e4. -/

namespace S13K.Chunks.C00602

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00602.txt"

theorem chk : chkChunk S N 48954 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 48954 49031 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00602
