import S13Kernel.Data.Keys

/-! Keys number 74869 to 74984. `data/c/c00874.txt` has sha256 d7ad8e816860f74ac782cebb2b00f726a4ba879188ff8c298740a496e901a15f. -/

namespace S13K.Chunks.C00874

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00874.txt"

theorem chk : chkChunk S N 74869 116 ces = true := by decide +kernel

theorem ok : RangeOK S N 74869 74985 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00874
