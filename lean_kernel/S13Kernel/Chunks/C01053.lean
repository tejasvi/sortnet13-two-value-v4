import S13Kernel.Data.Keys

/-! Keys number 93929 to 94043. `data/c/c01053.txt` has sha256 8fa89f3e8a5a295211f10aa765d0b43ca390a7ab32780f4e8e26384592c32348. -/

namespace S13K.Chunks.C01053

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01053.txt"

theorem chk : chkChunk S N 93929 115 ces = true := by decide +kernel

theorem ok : RangeOK S N 93929 94044 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01053
