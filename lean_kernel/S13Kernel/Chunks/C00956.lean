import S13Kernel.Data.Keys

/-! Keys number 83373 to 83478. `data/c/c00956.txt` has sha256 737cb0d20ec10be7b4d7a6f0f3aad6ca73b864029cbc0bd36bd05159a3fb06bc. -/

namespace S13K.Chunks.C00956

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00956.txt"

theorem chk : chkChunk S N 83373 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 83373 83479 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00956
