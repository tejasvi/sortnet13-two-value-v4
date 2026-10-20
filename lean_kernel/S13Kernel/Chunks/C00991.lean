import S13Kernel.Data.Keys

/-! Keys number 87051 to 87161. `data/c/c00991.txt` has sha256 85329549314182e4143144e3c63e816442823c55763fcadbf5fa9e0e6a010b02. -/

namespace S13K.Chunks.C00991

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00991.txt"

theorem chk : chkChunk S N 87051 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 87051 87162 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00991
