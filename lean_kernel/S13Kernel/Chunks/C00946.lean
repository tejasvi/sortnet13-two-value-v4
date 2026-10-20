import S13Kernel.Data.Keys

/-! Keys number 82341 to 82437. `data/c/c00946.txt` has sha256 81f602939eb4b4126e8572ffc1a0e5c2488a40846d9333633b7b21cffeee2824. -/

namespace S13K.Chunks.C00946

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00946.txt"

theorem chk : chkChunk S N 82341 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 82341 82438 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00946
