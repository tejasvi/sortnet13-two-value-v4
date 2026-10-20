import S13Kernel.Data.Keys

/-! Keys number 48879 to 48953. `data/c/c00601.txt` has sha256 31e21b345b855b2d365f29054804b313f2784cb46e7b8ed5aee4b6a21dfa6e3c. -/

namespace S13K.Chunks.C00601

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00601.txt"

theorem chk : chkChunk S N 48879 75 ces = true := by decide +kernel

theorem ok : RangeOK S N 48879 48954 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00601
