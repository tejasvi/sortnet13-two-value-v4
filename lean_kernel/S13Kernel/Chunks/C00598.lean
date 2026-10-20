import S13Kernel.Data.Keys

/-! Keys number 48634 to 48715. `data/c/c00598.txt` has sha256 d83a49e31f776450186b156924cb95d1d122da8d01ab096ee021b6fd234c521d. -/

namespace S13K.Chunks.C00598

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00598.txt"

theorem chk : chkChunk S N 48634 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 48634 48716 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00598
