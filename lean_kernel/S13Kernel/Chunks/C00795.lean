import S13Kernel.Data.Keys

/-! Keys number 67155 to 67242. `data/c/c00795.txt` has sha256 4c96520f382b870daebff75995d0a812cca82786e2f4081eb28aeeccb105f3b0. -/

namespace S13K.Chunks.C00795

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00795.txt"

theorem chk : chkChunk S N 67155 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 67155 67243 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00795
