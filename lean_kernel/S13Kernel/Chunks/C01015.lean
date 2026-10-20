import S13Kernel.Data.Keys

/-! Keys number 89712 to 89828. `data/c/c01015.txt` has sha256 11b3a2483671e91f4376e008fd3bb60bea25b951b6e245e8e3679cc654d07dc6. -/

namespace S13K.Chunks.C01015

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01015.txt"

theorem chk : chkChunk S N 89712 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 89712 89829 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01015
