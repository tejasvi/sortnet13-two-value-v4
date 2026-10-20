import S13Kernel.Data.Keys

/-! Keys number 42021 to 42131. `data/c/c00529.txt` has sha256 dedab2ac505cc4daaeae8646c691afd0eeff1278738f4ffc341a0eff1233aea1. -/

namespace S13K.Chunks.C00529

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00529.txt"

theorem chk : chkChunk S N 42021 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 42021 42132 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00529
