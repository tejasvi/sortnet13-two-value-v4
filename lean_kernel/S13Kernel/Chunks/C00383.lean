import S13Kernel.Data.Keys

/-! Keys number 29159 to 29276. `data/c/c00383.txt` has sha256 f7a58d4e7e498a0c909c6ee81373a76ef4c8bee7dea6735ce46fcfee268eb12a. -/

namespace S13K.Chunks.C00383

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00383.txt"

theorem chk : chkChunk S N 29159 118 ces = true := by decide +kernel

theorem ok : RangeOK S N 29159 29277 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00383
