import S13Kernel.Data.Keys

/-! Keys number 43096 to 43204. `data/c/c00540.txt` has sha256 a8ecdf35b8c4fa139edfdb8e6d2554243c59ab033588a34ee9b5d62a50ef2326. -/

namespace S13K.Chunks.C00540

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00540.txt"

theorem chk : chkChunk S N 43096 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 43096 43205 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00540
