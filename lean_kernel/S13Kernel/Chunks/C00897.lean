import S13Kernel.Data.Keys

/-! Keys number 77336 to 77442. `data/c/c00897.txt` has sha256 886d8d17d35abfc0bfb6c1ae07846a1d6ae6aab7a04e3583454784055727e938. -/

namespace S13K.Chunks.C00897

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00897.txt"

theorem chk : chkChunk S N 77336 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 77336 77443 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00897
