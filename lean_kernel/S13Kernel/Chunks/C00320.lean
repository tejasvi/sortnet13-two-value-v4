import S13Kernel.Data.Keys

/-! Keys number 23472 to 23575. `data/c/c00320.txt` has sha256 bdcba9b3bf952f7f007fa5f74c8e726b63444ffef48b6fbc6caf85cf886417b7. -/

namespace S13K.Chunks.C00320

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00320.txt"

theorem chk : chkChunk S N 23472 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 23472 23576 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00320
