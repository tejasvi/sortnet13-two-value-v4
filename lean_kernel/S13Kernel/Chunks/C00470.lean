import S13Kernel.Data.Keys

/-! Keys number 36660 to 36745. `data/c/c00470.txt` has sha256 121ca43aa2e1eb5e2c2a199934c377b26e4020418760cebe160149356a347cbf. -/

namespace S13K.Chunks.C00470

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00470.txt"

theorem chk : chkChunk S N 36660 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 36660 36746 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00470
