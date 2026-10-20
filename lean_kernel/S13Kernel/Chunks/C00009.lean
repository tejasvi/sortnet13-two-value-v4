import S13Kernel.Data.Keys

/-! Keys number 368 to 404. `data/c/c00009.txt` has sha256 389e1f1a01016b4356277e66fbfb293887e2226f0f928ec7a63480e9c0db88fc. -/

namespace S13K.Chunks.C00009

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00009.txt"

theorem chk : chkChunk S N 368 37 ces = true := by decide +kernel

theorem ok : RangeOK S N 368 405 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00009
