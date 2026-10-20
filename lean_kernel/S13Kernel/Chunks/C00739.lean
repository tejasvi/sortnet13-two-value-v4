import S13Kernel.Data.Keys

/-! Keys number 61828 to 61930. `data/c/c00739.txt` has sha256 6b009451c7e63548f37ae89629042cb108e01e602922cebda0f5685dac012b4e. -/

namespace S13K.Chunks.C00739

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00739.txt"

theorem chk : chkChunk S N 61828 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 61828 61931 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00739
