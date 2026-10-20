import S13Kernel.Data.Keys

/-! Keys number 78788 to 78892. `data/c/c00911.txt` has sha256 567621f3a0f2a921788908c91cecf255321ea99dfa7fe810760f57bae0b85881. -/

namespace S13K.Chunks.C00911

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00911.txt"

theorem chk : chkChunk S N 78788 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 78788 78893 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00911
