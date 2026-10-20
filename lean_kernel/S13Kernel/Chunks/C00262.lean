import S13Kernel.Data.Keys

/-! Keys number 18850 to 18937. `data/c/c00262.txt` has sha256 633f87059bb169cc6463a578244181ff9c2c221b6c25ba2d49263958aba77435. -/

namespace S13K.Chunks.C00262

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00262.txt"

theorem chk : chkChunk S N 18850 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 18850 18938 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00262
