import S13Kernel.Data.Keys

/-! Keys number 60562 to 60657. `data/c/c00726.txt` has sha256 68742b97431352f4703368170b2e8f7824c30b23f3e9be8d3e4387d7eb9f536a. -/

namespace S13K.Chunks.C00726

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00726.txt"

theorem chk : chkChunk S N 60562 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 60562 60658 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00726
