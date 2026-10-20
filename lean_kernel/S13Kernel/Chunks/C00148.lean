import S13Kernel.Data.Keys

/-! Keys number 9676 to 9766. `data/c/c00148.txt` has sha256 8cc53d2de27cf9e17e97915fb44c4f0a92778721030083d7b170d0971bac96b4. -/

namespace S13K.Chunks.C00148

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00148.txt"

theorem chk : chkChunk S N 9676 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 9676 9767 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00148
