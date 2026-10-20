import S13Kernel.Data.Keys

/-! Keys number 33082 to 33160. `data/c/c00427.txt` has sha256 9071c0582d7a5d5847f575643acdd269ba3262c50a5cd9ef093262671f6c8585. -/

namespace S13K.Chunks.C00427

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00427.txt"

theorem chk : chkChunk S N 33082 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 33082 33161 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00427
