import S13Kernel.Data.Keys

/-! Keys number 21518 to 21604. `data/c/c00297.txt` has sha256 a282a3621730f59888d55fcd29482a733456c08396ad669094337125b905fd7c. -/

namespace S13K.Chunks.C00297

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00297.txt"

theorem chk : chkChunk S N 21518 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 21518 21605 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00297
