import S13Kernel.Data.Keys

/-! Keys number 4179 to 4242. `data/c/c00073.txt` has sha256 827c7b28eeba3eadf6fadfd3964567a95d3dbbe8d738e7beedd48eba5568bd0d. -/

namespace S13K.Chunks.C00073

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00073.txt"

theorem chk : chkChunk S N 4179 64 ces = true := by decide +kernel

theorem ok : RangeOK S N 4179 4243 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00073
