import S13Kernel.Data.Keys

/-! Keys number 40429 to 40508. `data/c/c00511.txt` has sha256 5b2c42738e06f7b01e719c557563672893dd4571b8b77125684e48c64b7c56bd. -/

namespace S13K.Chunks.C00511

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00511.txt"

theorem chk : chkChunk S N 40429 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 40429 40509 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00511
