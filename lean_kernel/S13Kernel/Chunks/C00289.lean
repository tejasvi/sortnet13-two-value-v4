import S13Kernel.Data.Keys

/-! Keys number 20922 to 20992. `data/c/c00289.txt` has sha256 2af85a38c528aa01d06240a0781b32b6aaef5f16cd5a206eb00c88ae37ffb25c. -/

namespace S13K.Chunks.C00289

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00289.txt"

theorem chk : chkChunk S N 20922 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 20922 20993 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00289
