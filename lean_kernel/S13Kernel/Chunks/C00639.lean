import S13Kernel.Data.Keys

/-! Keys number 52160 to 52262. `data/c/c00639.txt` has sha256 8078dc81c36869b5508a72350c138bb5cafc4247c4fbe833df529efba7487473. -/

namespace S13K.Chunks.C00639

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00639.txt"

theorem chk : chkChunk S N 52160 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 52160 52263 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00639
