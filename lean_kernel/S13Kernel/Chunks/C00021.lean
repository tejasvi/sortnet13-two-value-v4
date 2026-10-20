import S13Kernel.Data.Keys

/-! Keys number 983 to 1021. `data/c/c00021.txt` has sha256 9ac661756c619d2ef7d8b0963ca61cb18983d1dc6db324d5231c3ee046143f97. -/

namespace S13K.Chunks.C00021

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00021.txt"

theorem chk : chkChunk S N 983 39 ces = true := by decide +kernel

theorem ok : RangeOK S N 983 1022 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00021
