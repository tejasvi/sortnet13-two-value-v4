import S13Kernel.Data.Keys

/-! Keys number 19200 to 19287. `data/c/c00266.txt` has sha256 a52539c35b097b1b351cbda1817f2f69a141f1c6a9ec49e08c78715b8f04991f. -/

namespace S13K.Chunks.C00266

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00266.txt"

theorem chk : chkChunk S N 19200 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 19200 19288 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00266
