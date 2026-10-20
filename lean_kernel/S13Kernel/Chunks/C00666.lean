import S13Kernel.Data.Keys

/-! Keys number 54823 to 54922. `data/c/c00666.txt` has sha256 bfd4fbe71863fe07f650d9b936942def989dcd031ab0aa784fdf545ebf0b1922. -/

namespace S13K.Chunks.C00666

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00666.txt"

theorem chk : chkChunk S N 54823 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 54823 54923 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00666
