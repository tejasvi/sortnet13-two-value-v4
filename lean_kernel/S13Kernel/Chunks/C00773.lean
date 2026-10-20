import S13Kernel.Data.Keys

/-! Keys number 65194 to 65277. `data/c/c00773.txt` has sha256 87d008f3945cf501fccfe8ceb2763684bac49ec0eab2edda12c51808ed72aaad. -/

namespace S13K.Chunks.C00773

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00773.txt"

theorem chk : chkChunk S N 65194 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 65194 65278 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00773
