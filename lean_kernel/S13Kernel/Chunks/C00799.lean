import S13Kernel.Data.Keys

/-! Keys number 67507 to 67611. `data/c/c00799.txt` has sha256 0615e578df4e659a2adfe3eb84be2b7461971b0d28080a818a423a8a2e7e0a9f. -/

namespace S13K.Chunks.C00799

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00799.txt"

theorem chk : chkChunk S N 67507 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 67507 67612 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00799
