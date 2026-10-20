import S13Kernel.Data.Keys

/-! Keys number 11295 to 11352. `data/c/c00171.txt` has sha256 99b2da9bf624a64cc41f12ee4162244f51df8670bea72b90c73e100f93025ed6. -/

namespace S13K.Chunks.C00171

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00171.txt"

theorem chk : chkChunk S N 11295 58 ces = true := by decide +kernel

theorem ok : RangeOK S N 11295 11353 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00171
