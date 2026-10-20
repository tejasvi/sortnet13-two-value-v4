import S13Kernel.Data.Keys

/-! Keys number 75626 to 75745. `data/c/c00881.txt` has sha256 efcb6b3ecbc0146edff8c8c120ec2561434d94938a06db8727c7b659d2dfdfb1. -/

namespace S13K.Chunks.C00881

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00881.txt"

theorem chk : chkChunk S N 75626 120 ces = true := by decide +kernel

theorem ok : RangeOK S N 75626 75746 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00881
