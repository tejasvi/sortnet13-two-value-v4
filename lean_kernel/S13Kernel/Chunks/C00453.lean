import S13Kernel.Data.Keys

/-! Keys number 35140 to 35220. `data/c/c00453.txt` has sha256 af8aed662980eba0843b63b771077393d77ffa13cb665a879c7e668c41d9ca6a. -/

namespace S13K.Chunks.C00453

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00453.txt"

theorem chk : chkChunk S N 35140 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 35140 35221 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00453
