import S13Kernel.Data.Keys

/-! Keys number 7672 to 7745. `data/c/c00123.txt` has sha256 7679493785052140acbb2698f0fe04d38d533450bfbca79e35877b7858272a95. -/

namespace S13K.Chunks.C00123

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00123.txt"

theorem chk : chkChunk S N 7672 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 7672 7746 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00123
