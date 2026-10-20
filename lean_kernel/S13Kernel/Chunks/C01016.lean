import S13Kernel.Data.Keys

/-! Keys number 89829 to 89954. `data/c/c01016.txt` has sha256 3cfafa458f87cd0c875586eeb396e1982273891a685182e4560f3a719dc99caa. -/

namespace S13K.Chunks.C01016

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01016.txt"

theorem chk : chkChunk S N 89829 126 ces = true := by decide +kernel

theorem ok : RangeOK S N 89829 89955 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01016
