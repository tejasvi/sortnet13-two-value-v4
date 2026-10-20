import S13Kernel.Data.Keys

/-! Keys number 3914 to 3971. `data/c/c00069.txt` has sha256 c53587f25910043d6fd337fb2d782e4e4dff935e33d4ff2957fdb49135a13da5. -/

namespace S13K.Chunks.C00069

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00069.txt"

theorem chk : chkChunk S N 3914 58 ces = true := by decide +kernel

theorem ok : RangeOK S N 3914 3972 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00069
