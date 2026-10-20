import S13Kernel.Data.Keys

/-! Keys number 71923 to 72013. `data/c/c00843.txt` has sha256 84553cf0f6e9fad201d6820ee9db680fbca61c1fc46c94a453f29e03126d44e6. -/

namespace S13K.Chunks.C00843

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00843.txt"

theorem chk : chkChunk S N 71923 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 71923 72014 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00843
