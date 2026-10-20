import S13Kernel.Data.Keys

/-! Keys number 67987 to 68086. `data/c/c00804.txt` has sha256 141e2c357184b039f668a70784635134843d41b080c757f24c94452c9186cbcf. -/

namespace S13K.Chunks.C00804

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00804.txt"

theorem chk : chkChunk S N 67987 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 67987 68087 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00804
