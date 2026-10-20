import S13Kernel.Data.Keys

/-! Keys number 41187 to 41260. `data/c/c00520.txt` has sha256 999b28a354a19077f7388383677e31e314c40e5446d1d770cec6df78c4922c01. -/

namespace S13K.Chunks.C00520

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00520.txt"

theorem chk : chkChunk S N 41187 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 41187 41261 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00520
