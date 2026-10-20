import S13Kernel.Data.Keys

/-! Keys number 51599 to 51689. `data/c/c00633.txt` has sha256 cb3d1a85a685299920ab5b746ad9cd83d014e2bc7b8428bfbc4090fca0709d78. -/

namespace S13K.Chunks.C00633

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00633.txt"

theorem chk : chkChunk S N 51599 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 51599 51690 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00633
