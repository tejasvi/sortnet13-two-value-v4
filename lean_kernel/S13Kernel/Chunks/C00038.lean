import S13Kernel.Data.Keys

/-! Keys number 1968 to 2037. `data/c/c00038.txt` has sha256 eb05d359b7c3f5f3c694a0fd7c9befe245e219416aa85302f89922178df204e0. -/

namespace S13K.Chunks.C00038

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00038.txt"

theorem chk : chkChunk S N 1968 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 1968 2038 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00038
