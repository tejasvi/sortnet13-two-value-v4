import S13Kernel.Data.Keys

/-! Keys number 52859 to 52951. `data/c/c00646.txt` has sha256 34cb71f4e185c90a13c4e687c3a5363bdf3a0ffd67ebd4a04f17e9cd4791bdd3. -/

namespace S13K.Chunks.C00646

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00646.txt"

theorem chk : chkChunk S N 52859 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 52859 52952 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00646
