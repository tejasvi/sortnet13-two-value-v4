import S13Kernel.Data.Keys

/-! Keys number 11903 to 11986. `data/c/c00180.txt` has sha256 a9a3eebfff22a2aba74e00e864a0d3ef3e610537124508ac725359f3b0f12b8f. -/

namespace S13K.Chunks.C00180

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00180.txt"

theorem chk : chkChunk S N 11903 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 11903 11987 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00180
